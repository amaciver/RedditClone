class SessionsController < ApplicationController

  def new
  end

  def create
    username, password = user_params.values
    user = User.find_by_username(username)
    if user.nil?
      flash[:errors] = "User does not exist."
      redirect_to new_session_url
    else
      if user.is_password?(password)
        login(user)
        redirect_to '/'
      else
        flash[:watermelon] = "Incorrect Password."
        redirect_to new_session_url
      end
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
