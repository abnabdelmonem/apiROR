class ReactionsController < ApplicationController
    before_action :require_login
    before_action :find_reactable
    before_action :has_access?

    def index
        @reactions = @reactable.reactions
        render json: @reactions
    end

    def create
        @reaction = Reaction.create!(reaction_params)
        render json: @reaction
    end

    def destroy
        @reaction = @reactable.reactions.find(params[:id])
        authorize @reaction
        @reaction.destroy
    end
    private

        def find_reactable
            if params[:reply_id]
                @reactable = Reply.find(params[:reply_id])
            elsif params[:comment_id]
                @reactable = Comment.find(params[:comment_id])
            else
                @reactable = Post.find(params[:post_id])
            end
        end

        def reaction_params
            {user_id: @user.id, reactable_type: @reactable.class.name, reactable_id: @reactable.id, reaction_type: params[:reaction_type]}
        end

        def has_access?
            @post = Post.find(params[:post_id])
            authorize @post, :show?
        end
end
