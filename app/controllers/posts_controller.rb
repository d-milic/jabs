class PostsController < ApplicationController
  def show
    required_post
  end

  def new
    @user = User.find(user_id_from_session)
    @post = Post.new
    @categories = Category.sorted
  end

  def create
    @user = User.find(user_id_from_session)

    begin
      @post = @user.posts.create!(post_params)
    rescue ActiveRecord::ActiveRecordError
      redirect_to_new_with_error_message('There was an error saving this post. Check if all the fields are filled out.')
    rescue StandardError
      redirect_to_new_with_error_message('There was an error saving this post. Try again later.')
    else
      redirect_to(user_post_path(user_username: @user.username,
                                 title: @post.title))
    end
  end

  def edit
    required_post
    @categories = Category.sorted
  end

  def update
    @post = User.find(user_id_from_session).posts.find_by_title(params[:title])

    begin
      @post.update_attributes!(post_params)
    rescue ActiveRecord::ActiveRecordError
      redirect_to_edit_with_error_message('There was an error updating this post. Check if all the fields are filled out.')
    rescue ActiveRecord::RecordInvalid
      redirect_to_edit_with_error_message('There was an error updating this post. Check if all the fields are filled out.')
    rescue StandardError
      redirect_to_edit_with_error_message('There was an error updating this post. Try again later.')
    else
      redirect_to(user_post_path(user_username: @post.user.username,
                                 title: @post.title))
    end
  end

  private

  def redirect_to_new_with_error_message(error_message)
    flash[:error] = error_message
    redirect_to(new_user_post_path(user_username: @user.username)) && return
  end

  def redirect_to_edit_with_error_message(error_message)
    flash[:error] = error_message
    redirect_to(edit_user_post_path(user_username: @post.user.username,
                                    title: params[:title])) && return
  end

  def username_from_params
    params[:user_username]
  end

  def title_from_params
    params[:title]
  end

  def required_post
    @user = User.find_by_username(username_from_params)
    @post = @user.posts.find_by_title(title_from_params)
  end

  def post_params
    params.require(:post).permit(:title, :content, :category_id)
  end
end
