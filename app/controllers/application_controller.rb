class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from Exceptions::AccessDenied, with: :access_denied
  
  def access_denied
    redirect_to root_path, alert: "Access denied"
  end
    
  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :admin_signed_in?
  
  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def user_signed_in?
    !!current_user
  end
  
  def admin_signed_in?
    user_signed_in? && current_user.admin
  end
  
  def require_admin!
    raise Exceptions::AccessDenied unless admin_signed_in?
  end
end
