class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user 


  STARS = [1, 2, 3, 4, 5]
  validates :stars, inclusion: { in: STARS ,
    message: "must be between 1 and 5" }
  validates :comment,  length: { minimum: 4 }

  def stars_as_percent
    (stars.to_f / 5 * 100).round
  end
end
