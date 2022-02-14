class CommentsController < ApplicationController
    before_action :require_login
    before_action :has_access?

    def index
        render json: @post.comments
    end

    def create
        @comment = Comment.new(comments_params)
        if @comment.save
            render json: @comment, status: :created
        else
            render json: @comment.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @comment = Comment.avaliable_to_delete(params[:id], @post.user_id, current_user_status)
        if @comment.nil?
            render json: {error: 'you can not delete this comment'}, status: :unauthorized
        else
            @comment.destroy
        end
    end

    def update
        @comment = Comment.find(params[:id])
        if @comment.user_id == current_user_status["user_id"]

            if @comment.update(comments_params)
                render json: @comment
            else
                render json: @comment.errors, status: :unprocessable_entity
            end
            
        else
            render json: {error: 'you can not edit this comment'}, status: :unauthorized
        end
    end

    private
    def comments_params
        body = params[:body]
        user_id = current_user_status["user_id"]
        post_id = params[:post_id]
        comment = {body: body, user_id: user_id, post_id: post_id}
        comment
    end

    def has_access?
        @post = Post.avaliable_to_show(params[:post_id], current_user_status)
        if @post.nil?
            render json: {error: 'you can not access this post'}, status: :unauthorized
        end
        @post
    end
end
