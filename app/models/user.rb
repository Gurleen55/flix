class User < ApplicationRecord
  has_secure_password

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie

  validates :name, presence: true

  validates :email, format: { with: /\S+@\S+/ }, 
                    uniqueness: { case_sensitive: false }

  def gravatar_id
    Digest::MD5.hexdigest(email.downcase)
  end
end
