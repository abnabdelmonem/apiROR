class ReactionSerializer < ActiveModel::Serializer
    attributes :id, :creator, :reaction_type
  
    def creator
      User.find(object.user_id).username
    end
  end