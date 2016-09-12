# Controller that handles user CRUD operations
class UsersController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])
    @posts = @user.posts
  end
end
