class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      send_mail
      flash[:success] = "Account successfully created!"
      redirect_to explore_path
    else
      render :new
    end
  end

  def show
    @photos = []
    current_user.orders.each do |order|
      order.order_photos.each do |order_photo|
        @photos << Photo.find(order_photo.photo_id)
      end
    end
    redirect_to "/404" unless current_user
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update_attributes(user_params)
      redirect_to profile_path
    else
      flash[:danger] = "Update failed, please enter valid information in all fields"
      render :edit
    end
  end

  private

    def send_mail
      NotificationsMailer.contact(
        name: "Imagine Photography",
        email: "#{@user.email}",
        message: "Congratulations! You have successfully created a new account
        with Imagine Photography! Log in to your account to browse and purchase
        photos and manage your profile."
      ).deliver_now
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :avatar, :header)
    end
end
