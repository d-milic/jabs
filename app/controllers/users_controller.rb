# Controller that handles user CRUD operations
class UsersController < ApplicationController
  def show
    @user = User.find(params[:user_id])
  end
end
