# Controller that handles user authentication
class AccessController < ApplicationController
  def login
  end

  def attempt_login
    user = User.find_by_username(params[:username])
    authorized_user = user.authenticate(params[:password]) if user
    if authorized_user
      session[:username] = authorized_user.username
      session[:user_id] = authorized_user.id
      redirect_to(controller: 'users', action: 'show',
                  username: authorized_user.username)
    else
      flash[:error] = 'Invalid username/password combination.'
      redirect_to(action: 'login')
    end
  end
end
