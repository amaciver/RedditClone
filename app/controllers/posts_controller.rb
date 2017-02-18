class PostsController < ApplicationController
  before_action :authorized_user, only: [:edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
  end

  def new
  end

  def create
    post = Post.new(post_params)
    post.author = current_user
    if post.save
      redirect_to post_url(post)
    else
      flash[:errors] = post.errors.full_messages
      redirect_to new_post_url
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to edit_post_url(params[:id])
    end
  end

  def destroy
    post = Post.find(params[:id])
    unless post.nil?
      post.destroy
    else
      flash[:errors] = "Post doesn't exist."
      redirect_to subs_url
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :url, :user_id, sub_ids: [])
  end

  def authorized_user
    post = Post.find(params[:id])

    unless current_user == post.author
      flash[:errors] = "Unauthorized user."
      redirect_to subs_url
    end
  end
end
