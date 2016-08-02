class PostsController < ApplicationController
  def show
    @post = Post.find(params[:post_id])
  end

  def new
  end

  def edit
    @post = Post.find(params[:post_id])
  end
end
