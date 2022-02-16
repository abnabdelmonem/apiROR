class PostSerializer < ActiveModel::Serializer
  attributes :id, :creator, :privacy, :message
  has_many :comments

  def creator
    User.find(object.user_id).username
  end

  def privacy
    if object.published
      "published"
    else
      "unpublished"
    end
  end
end
