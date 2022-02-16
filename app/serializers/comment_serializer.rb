class CommentSerializer < ActiveModel::Serializer
  attributes :id, :creator, :body
  has_many :replies

  def creator
    User.find(object.user_id).username
  end
end
