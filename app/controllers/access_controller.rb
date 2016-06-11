# Controller that handles user authentication
class AccessController < ApplicationController
  def login
  end

  def attempt_login
    render nothing: true
    user = User.find_by_username(params[:username])
    authorized_user = user.authenticate(params[:password]) if user
    if authorized_user
      session[:username] = authorized_user.username
    end
  end
end
