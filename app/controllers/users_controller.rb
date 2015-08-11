class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to menu_path
    else
      flash[:danger] = "Ya screwed something up parter, try again!"
      redirect_to sign_up_path
    end
  end

  def show
    redirect_to "/404" unless current_user
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :zipcode, :street_name)
  end
end
