require "twilio-ruby"
class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to menu_path
      flash[:success] = "#{@user.name} is signed in!"
    else
      redirect_to login_path
      flash[:danger] = "Invalid login information!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
