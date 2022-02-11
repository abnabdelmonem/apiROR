class Post < ApplicationRecord
  belongs_to :user
  validates :message,
            presence: true,
            length: { maximum: 350 }
end
