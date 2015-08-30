class Stores::PhotosController < ApplicationController
  before_action :set_photographer, only: [ :index, :create, :new, :show ]
  def index
    @photos = @photographer.photos
    # @categories = Category.all
  end

  def new
    @photo = Photo.new
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
