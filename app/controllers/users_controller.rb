class UsersController < ApplicationController

  before_action :require_signin, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_correct_user, only: [:edit, :update, :destroy]
  def index
    @users = User.all
  end

  def show
    @reviews = @user.reviews
    @favorite_movies = @user.favorite_movies
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id  # Automatically log in the user after creation
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit 
  end

  def update 
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil  # Log out the user after deletion
    redirect_to movies_url, alert: 'Account successfully deleted', status: :see_other
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
     @user = User.find(params[:id])
  end
  
end
