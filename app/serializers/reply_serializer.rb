class ReplySerializer < ActiveModel::Serializer
  attributes :id, :creator, :body

  def creator
    User.find(object.user_id).username
  end
end
