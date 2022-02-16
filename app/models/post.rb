class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :message,
            presence: true,
            length: { maximum: 350 }
  
end
