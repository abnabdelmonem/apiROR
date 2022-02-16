class RepliesController < ApplicationController
    before_action :require_login
    before_action :has_access?

    def index
        @replies = @post.comments.find(params[:comment_id]).replies
        render json: @replies
    end

    def create
        @reply = Reply.new(replies_params)
        if @reply.save
            render json: @reply
        else
            render json: @reply.errors, status: :unprocessable_entity
        end
    end

    def update
        @reply = Reply.find(params[:id])
        if @reply.user_id == current_user_status["user_id"]

            if @reply.update(replies_params)
                render json: @reply
            else
                render json: @reply.errors, status: :unprocessable_entity
            end
            
        else
            render json: {error: 'you can not edit this reply'}, status: :unauthorized
        end
    end

    def destroy
        @reply = Reply.avaliable_to_delete(params[:id], @post.user_id, current_user_status)
        if @reply.nil?
            render json: {error: 'you can not delete this reply'}, status: :unauthorized
        else
            @reply.destroy
        end
    end

    private
    def has_access?
        @post = Post.avaliable_to_show(params[:post_id], current_user_status)
        if @post.nil?
            render json: {error: 'you can not access this post'}, status: :unauthorized
        end
        @post
    end

    def replies_params
        params.permit(:body, :comment_id).merge(user_id: current_user_status["user_id"])
    end
end
