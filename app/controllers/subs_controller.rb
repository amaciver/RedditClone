class SubsController < ApplicationController
  before_action :authorized_user, only: [:edit, :update]

  def index
  end

  def new
  end

  def create
    new_sub = Sub.new(sub_params)
    new_sub.user_id = current_user.id
    if new_sub.save
      redirect_to sub_url(new_sub)
    else
      flash[:errors] = "dumb"
      redirect_to new_sub_url
    end
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    if @sub
      render :show
    else
      flash[:errors] = "no Sub bro!"
      redirect_to subs_url
    end
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
    if @sub
      render :edit
    else
      flash[:errors] = "no Sub bro!"
      redirect_to subs_url
    end
  end

  def update
    @sub = Sub.find_by(id: params[:id])
    @sub.user_id = current_user.id

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = "wrong stuff!"
      redirect_to edit_sub_url(@sub)
    end
  end

  def destroy
    return
  end


  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def authorized_user
    sub = Sub.find(params[:id])
    unless current_user.id == sub.user_id
      flash[:errors] = "unauthorized"
      redirect_to subs_url
    end
  end
end
