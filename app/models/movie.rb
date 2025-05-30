class Movie < ApplicationRecord

  def self.released
    where("released_on < ?", Time.now).order("released_on desc")
  end

  def flop?
    total_gross < 225_000_000 || total_gross.blank?
  end
end
