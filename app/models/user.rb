class User < ApplicationRecord
    has_secure_password

    has_many :posts, dependent: :destroy

    enum role: %i[user admin].freeze

    validates :username,
              presence: true,
              uniqueness: true
              
    validates :password,
              length: { minimum: 6 },
              presence: true

end
