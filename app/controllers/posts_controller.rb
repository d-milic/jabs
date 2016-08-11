class PostsController < ApplicationController
  def show
    @post = Post.find(post_id_from_params)
  end

  def new
  end

  def edit
    @post = Post.find(post_id_from_params)
  end

  private

  def post_id_from_params
    params[:post_id]
  end
end
