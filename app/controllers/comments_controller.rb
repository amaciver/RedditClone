class CommentsController < ApplicationController
  before_action :authorized_user, only: [:new, :create]
  def new
    @post = Post.find(params[:post_id])
  end

  def create
    comment = Comment.new(comment_params)
    comment.author = current_user
    if comment.save
      redirect_to post_url(comment.post)
    else
      flash[:errors] = comment.errors.full_messages
      redirect_to new_post_comment_url(params[:comment][:post_id])
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  def authorized_user
    unless logged_in?
      flash[:errors] = "Log in. Please."
      redirect_to new_session_url
    end
  end

end
