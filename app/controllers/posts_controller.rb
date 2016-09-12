class PostsController < ApplicationController
  def show
    @user = User.find_by_username(username_from_params)
    @post = @user.posts.find_by_title(title_from_params)
  end

  def new
    @post = Post.new
    @user = User.find(user_id_from_session)
    @categories = Category.sorted
  end

  def create
    @user = User.find(user_id_from_session)

    begin
      @post = @user.posts.create!(post_params)
    rescue ActiveRecord::ActiveRecordError
      flash[:error] = 'There was an error saving this post.
                       Check if all the fields are filled out.'
      redirect_to(action: 'new')
    rescue StandardError
      flash[:error] = 'There was an error saving this post. Try again later.'
      redirect_to(action: 'new')
    else
      redirect_to(user_post_path(user_username: @post.user.username,
                                 title: @post.title))
    end
  end

  def edit
    @post = Post.find(post_id_from_params)
  end

  private

  def username_from_params
    params[:user_username]
  end

  def title_from_params
    params[:title]
  end

  def post_params
    params.require(:post).permit(:title, :content, :category_id)
  end
end
