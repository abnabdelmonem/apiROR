class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  has_many :replies, dependent: :destroy

  has_many :reactions, as: :reactable, dependent: :destroy

  validates :body, presence: :true

end
