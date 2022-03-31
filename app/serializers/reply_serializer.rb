class ReplySerializer < ActiveModel::Serializer
  attributes :id, :creator, :body, :reactions_count

  def creator
    User.find(object.user_id).username
  end
  def reactions_count
    object.reactions.count
  end
end
