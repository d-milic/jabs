class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = user_id_from_session

    begin
      @comment.save!(comment_params)
    rescue ActiveRecord::ActiveRecordError
      redirect_to_show_post_with_error_message('There was an error saving this comment. Did you provide the content?')
    rescue StandardError
      redirect_to_show_post_with_error_message('There was an error saving this comment. Try again later.')
    else
      redirect_to(user_post_path(@comment.post.user, @comment.post))
    end
  end

  def destroy
    comment = Comment.find(comment_id_from_params)
    comment.destroy
    redirect_to(user_post_path(comment.post.user, comment.post))
  end

  private

  def post_id_from_params
    params[:comment][:post_id]
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end

  def comment_id_from_params
    params[:id]
  end

  def redirect_to_show_post_with_error_message(error_message)
    @post = Post.find(post_id_from_params)
    flash[:error] = error_message
    redirect_to(user_post_path(@post.user, @post)) && return
  end
end
