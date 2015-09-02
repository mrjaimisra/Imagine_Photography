class StoresController < ApplicationController
  def index
    @photographers = Store.all
  end

  def show
    @photographer = Store.find_by(id: current_user.store_id)
  end

  def new
    @photographer = Store.new
  end

  def create
    @photographer = Store.new(store_params)
    if @photographer.save
      flash[:success] = "Your application has been received."
      NotificationsMailer.contact(
        name: "Imagine Photography",
        email: "#{current_user.email}",
        message: "Congratulations! You have successfully created a new business
        at Imagine Photography! Log in to your account to set up your profile
        and begin uploading and selling your photos."
      ).deliver_now
      redirect_to profile_path
    else
      flash.now[:warning] = "There was a problem with your information."
      render :new
    end
  end

  def edit
    @photographer = Store.find_by(url: params[:photographer])
  end

  def update
    @photographer = Store.find_by(url: params[:store][:url])
    if @photographer.save
      flash[:success] = "Store updated successfully."
      redirect_to photographer_path
    else
      flash.now[:warning] = "There was a problem updating your information."
      render :edit
    end
  end

  private

    def store_params
      params.require(:store).permit(:name, :email, :avatar, :header)
    end

end
