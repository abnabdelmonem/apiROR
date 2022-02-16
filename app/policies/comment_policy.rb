class CommentPolicy < ApplicationPolicy
  def destroy?
    @user.admin? || recordAuthor?|| isPostAuthor?
  end
  
  private
    def isPostAuthor?
      @post = Post.find(@record.post_id)
      @post.user_id == @user.id
    end
end
