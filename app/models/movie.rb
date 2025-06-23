class Movie < ApplicationRecord

  before_save :set_slug

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations
  has_one_attached :main_image

  RATINGS = %w(G PG PG-13 R NC-17).freeze

  validates :title, presence: true, uniqueness: true
  validates :released_on, :duration, presence: true

  validates :description, length: { minimum: 25 }

  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  validate :acceptable_image

  validates :rating, inclusion: { in: RATINGS }

  scope :released, -> { where("released_on < ?", Time.now).order("released_on desc") }
  scope :upcoming, -> { where("released_on > ?", Time.now).order("released_on desc") }
  scope :recent, ->(max=5) { released.limit(max) }

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

  def to_param
    slug
  end

  private

  def acceptable_image
    return unless main_image.attached?

    unless main_image.blob.byte_size <= 1.megabytes
      errors.add(:main_image, "is too big. Maximum size is 1MB")
    end

    acceptable_types = ["image/jpeg", "image/png"]

    unless acceptable_types.include?(main_image.blob.content_type)
      errors.add(:main_image, "must be a JPEG or PNG")
    end
  end

  def set_slug
    self.slug = title.parameterize
  end
end
