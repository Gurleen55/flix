class MoviesController < ApplicationController

  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  def index
    case params[:filter]
      when "upcoming"
        @movies = Movie.upcoming
      when "recent"
        @movies = Movie.recent
      else
        @movies = Movie.released
    end
    
  end

  def show
    @fans = @movie.fans
    if current_user
      @favorite = current_user.favorites.find_by(movie: @movie)
    end
    @genres = @movie.genres.order(:name)
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end

    
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie successfully created"
    else
      render :new, status: :unprocessable_entity
    end

    
  end

  def destroy
    @movie.destroy
    redirect_to movies_url, status: :see_other, alert: "Movie was successfully deleted"
  end

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:id])
    
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :released_on, :rating, :total_gross, :director, :duration, :main_image, 
                                    genre_ids: [])  
  end
end
