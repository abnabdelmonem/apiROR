class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :body, presence: :true

  def self.avaliable_to_delete(reply_id, post_author_id, current_user_status)
    @reply = Reply.find(reply_id)
      if (current_user_status["aud"] == ["admin"] ||
          @reply.user_id == current_user_status["user_id"] ||
          post_author_id == current_user_status["user_id"])
          
        @reply
      else
        nil
      end
  end
end
