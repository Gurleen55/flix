class ApplicationController < ActionController::Base

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def current_user_admin?
    current_user && current_user.admin?
  end

  helper_method :current_user_admin?

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?

  def require_signin
    unless current_user
      flash[:alert] = "Please sign in first."
      session[:intended_url] = request.url
      redirect_to new_session_url # Redirect to the sign-in page
    end
  end

  def require_admin
    unless current_user_admin?
      flash[:alert] = "You must be an admin to perform this action."
      redirect_to root_url # Redirect to the home page or another appropriate page
    end
  end

  def require_correct_user
    # assuming @user or @review is already set by a before_action
    resource_owner = @user || @review&.user
    unless current_user == resource_owner
      redirect_to root_url,
                  alert: 'You can only edit or delete your own resources.',
                  status: :see_other
    end
  end
end
