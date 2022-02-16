class PostSerializer < ActiveModel::Serializer
  attributes :id, :creator, :message
  has_many :comments

  def creator
    User.find(object.user_id).username
  end
end
