class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_by(twitter_uid:request.env["omniauth.auth"]["uid"])
    @user.update_attributes({
      name: request.env["omniauth.auth"]["info"]["name"],
      last_login_at: Time.now
    })
    session[:user_id] = @user.id
    redirect_to root_path    
  end
  
  def destroy
    reset_session
    redirect_to root_path, notice: "You've been signed out"
  end
end