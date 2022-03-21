class RepliesController < ApplicationController
    before_action :require_login
    before_action :has_access?
    before_action :find_reply, except: [:index, :create]

    def index
        @replies = @post.comments.find(params[:comment_id]).replies
        render json: @replies
    end

    def create
        @reply = Reply.create!(replies_params)
        render json: @reply
    end

    def update
        authorize @reply
        @reply.update!(replies_params)
        render json: @reply 
    end

    def destroy
        authorize @reply
        @reply.destroy
    end

    private
    def has_access?
        @post = Post.find(params[:post_id])
        authorize @post, :show?
    end

    def replies_params
        params.permit(:body, :comment_id).merge(user_id: @user.id)
    end

    def find_reply
        @reply = Reply.find(params[:id])
    end
end
