module MoviesHelper
  def total_gross(movie)
    if movie.flop?
      "FLOP!"
    else
      number_to_currency(movie.total_gross, precision: 0)
    end   
  end

  def year_of(movie)
    movie.released_on.year
  end

  def average_stars(movie)
    if movie.average_stars.blank?
      content_tag(:strong, "No reviews")
    else
      pluralize(number_with_precision(movie.average_stars, precision: 1), "star")
    end
  end

  def nav_link_to(name, path)
    if current_page?(path)
      link_to name, path, class: "active"
    else
      link_to name, path
    end
  end

  def main_image(movie)
    if movie.main_image.attached?
      image_tag movie.main_image
    else
      image_tag "placeholder.png"
    end
  end
end
