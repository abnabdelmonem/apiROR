class ReplyPolicy < ApplicationPolicy
  def destroy?
    @user.admin? || recordAuthor?|| isPostAuthor?
  end
  
  private
    def isPostAuthor?
      comment = Comment.find(@record.comment_id)
      @post = Post.find(comment.post_id)
      @post.user_id == @user.id
    end
end
