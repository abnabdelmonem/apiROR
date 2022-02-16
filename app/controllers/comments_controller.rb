class CommentsController < ApplicationController
    before_action :require_login
    before_action :has_access?
    before_action :find_comment, except: [:index, :create]

    def index
        render json: @post.comments
    end

    def show
        render json: @comment
    end

    def create
        @comment = Comment.new(comments_params)
        @comment.save!
        render json: @comment
    end

    def destroy
        authorize @comment
        @comment.destroy
    end

    def update
        authorize @comment
        @comment.update!(comments_params)
        render json: @comment
    end

    private
    def comments_params
        params.permit(:body, :post_id).merge(user_id: @user.id)
    end

    def has_access?
        @post = Post.find(params[:post_id])
        authorize @post, :show?
    end

    def find_comment
        @comment = Comment.find(params[:id])
    end
end
