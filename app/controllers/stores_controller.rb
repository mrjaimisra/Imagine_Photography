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
      redirect_to profile_path
    else
      flash.now[:warning] = "There was a problem with your information."
      render :new
    end
  end

  private

    def store_params
      params.require(:store).permit(:name, :email, :avatar, :header)
    end

end
