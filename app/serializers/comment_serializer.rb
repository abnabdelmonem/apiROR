class CommentSerializer < ActiveModel::Serializer
  attributes :id, :creator, :body, :reactions_count
  has_many :replies

  def creator
    User.find(object.user_id).username
  end
  def reactions_count
    object.reactions.count
  end
end
