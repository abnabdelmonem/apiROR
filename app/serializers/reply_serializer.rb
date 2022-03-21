class ReplySerializer < ActiveModel::Serializer
  attributes :id, :creator, :body
  has_many :reactions
  def creator
    User.find(object.user_id).username
  end
end
