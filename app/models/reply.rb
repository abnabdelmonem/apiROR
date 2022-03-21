class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  has_many :reactions, as: :reactable, dependent: :destroy
  
  validates :body, presence: :true

end
