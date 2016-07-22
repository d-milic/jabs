# Controller that handles user authentication
class AccessController < ApplicationController
  def login
  end

  def attempt_login
    user = User.find_by_username(params[:username])
    authorized_user = user.authenticate(params[:password]) if user
    if authorized_user
      session[:username] = authorized_user.username
      redirect_to(controller: 'users', action: 'show', user_id: authorized_user)
    else
      flash[:error] = 'Invalid username/password combination.'
      redirect_to(action: 'login')
    end
  end
end
