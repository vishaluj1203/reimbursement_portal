class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :admin?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def admin?
    logged_in? && current_user.admin?
  end

  def require_login
    unless logged_in?
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def require_admin
    unless admin?
      render json: { error: "Forbidden" }, status: :forbidden
    end
  end
end
