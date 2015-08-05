class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # create user
    user = User.create(user_params)
    session[:user_id] = user.id
    # create session when log in

    redirect_to menu_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end