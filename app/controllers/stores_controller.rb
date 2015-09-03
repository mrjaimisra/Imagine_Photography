class StoresController < ApplicationController
  def index
    @photographers = Store.all
  end

  def new
    @photographer = Store.new
  end

  def create
    @photographer = Store.new(store_params)
    if @photographer.save
      set_role
      send_mail
      flash[:success] = "Your application has been received."
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
    if @photographer.update_attributes(store_params)
      redirect_to photographer_photos_path(photographer: @photographer.url)
    else
      render :edit
    end
  end

  private
    def set_role
      current_user.roles <<  Role.find_by(name: "store_admin")
      current_user.update_attribute(:store_id, @photographer.id)
    end

    def send_mail
      NotificationsMailer.contact(
        name: "Imagine Photography",
        email: "#{current_user.email}",
        message: "Congratulations! You have successfully created a new business
        at Imagine Photography! Log in to your account to set up your profile
        and begin uploading and selling your photos."
      ).deliver_now
    end

    def store_params
      params.require(:store).permit(:name, :email, :avatar, :header)
    end

end
