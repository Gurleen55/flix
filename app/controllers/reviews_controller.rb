class ReviewsController < ApplicationController

  before_action :require_signin 
  before_action :set_movie
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :require_correct_user, only: [:edit, :update, :destroy]
  def index
    @reviews = @movie.reviews
  end

  def new   
    @review = @movie.reviews.new
  end

  def create
      
    @review = @movie.reviews.new(review_params)
    @review.user = current_user
    
    if @review.save
      redirect_to movie_reviews_url(@movie), notice: 'Review was successfully posted.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to movie_reviews_url(@movie), notice: 'Review was successfully deleted.'
  end

  def edit   
  end

  def update 
    if @review.update(review_params)
      redirect_to movie_reviews_url(@movie), notice: 'Review was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:name, :comment, :stars)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_review
    @review = @movie.reviews.find(params[:id])
  end
  
end
