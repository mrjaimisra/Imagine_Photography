class Stores::PhotosController < ApplicationController
  before_action :set_photographer, only: [:index, :create, :new, :show]

  def index
    @photos = @photographer.photos.paginate(page: params[:page]).order('created_at DESC')
  end

  def new
    if current_user.store_id == current_store.id
      @photographer = Store.find_by(url: params[:photographer])
      @photo = Photo.new
    else
      redirect_to root_path
    end
  end

  def create
    photo = @photographer.photos.build(photo_params)
    if photo.save
      redirect_to photographer_photos_path
    else
      flash.now[:error] = photo.errors.full_messages.join(". ")
      render :new
    end
  end

  def show
  end

  private

    def photo_params
      params.require(:photo).permit(:name, :description, :price, :image, :category_id)
    end

    def set_photographer
      @photographer = Store.find_by(url: params[:photographer])
    end
end
