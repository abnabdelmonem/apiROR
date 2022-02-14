class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  has_many :replies, dependent: :destroy

  validates :body, presence: :true

    private
    def self.avaliable_to_delete(comment_id, post_author_id, current_user_status)
      @comment = Comment.find(comment_id)
      if (current_user_status["aud"] == ["admin"] ||
          @comment.user_id == current_user_status["user_id"] ||
          post_author_id == current_user_status["user_id"])

        @comment
      else
        nil
      end
    end
end
