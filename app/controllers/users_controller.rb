class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Account successfully created!"
      redirect_to explore_path
    else
      flash[:danger] = "Ya screwed something up parter, try again!"
      redirect_to sign_up_path
    end
  end

  def show
    redirect_to "/404" unless current_user
  end

  def edit
    @user = current_user
  end

  def update
    current_user.update_attributes(user_params)
    current_user.save!
    redirect_to profile_path(current_user)
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
