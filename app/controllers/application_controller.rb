class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def admin_signed_in?
    true
  end
  helper_method :admin_signed_in?
end
