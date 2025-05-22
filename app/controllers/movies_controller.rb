class MoviesController < ApplicationController
  def index
    @movies = ["inception", "interstellar", "the dark knight", "the matrix", "pulp fiction"]
  end
end
