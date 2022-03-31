class PostSerializer < ActiveModel::Serializer
  attributes :id, :creator, :privacy, :message, :reactions_count
  has_many :comments

  def creator
    User.find(object.user_id).username
  end

  def reactions_count
    object.reactions.count
  end
  def privacy
    if object.published
      "published"
    else
      "unpublished"
    end
  end

end
