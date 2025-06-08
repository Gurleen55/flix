class Movie < ApplicationRecord

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user

  RATINGS = %w(G PG PG-13 R NC-17)

  validates :title, :released_on, :duration, presence: true

  validates :description, length: { minimum: 25 }

  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }

  validates :image_file_name, format: {
  with: /\w+\.(jpg|png)\z/i,
  message: "must be a JPG or PNG image"
  }

  validates :rating, inclusion: { in: RATINGS }

  def self.released
    where("released_on < ?", Time.now).order("released_on desc")
  end

  def flop?
    unless (reviews.count < 50 && average_stars < 4)
      total_gross < 225_000_000 || total_gross.blank?
    end
  end

  def average_stars
    return 0 if reviews.empty?
    reviews.average(:stars)
  end

  def average_stars_as_percentage
    return 0 if reviews.empty?
    (average_stars / 5.0 * 100)
  end
end
