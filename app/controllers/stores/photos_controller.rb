class Stores::PhotosController < ApplicationController
  before_action :set_photographer, only: [:index, :create, :new, :show, :edit, :update]

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

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      redirect_to photo_path(@photo)
    else
      flash[:danger] = "Update failed, please enter valid information in all fields"
      redirect_to edit_photographer_photo_path(@photo,
                                 photographer: @photographer.url)
    end
  end

  def destroy
    photo = Photo.find(params[:id])
    photo.destroy

    redirect_to explore_path
    flash[:message] = "Photo successfully deleted"
  end

  private

    def photo_params
      params.require(:photo).permit(:name, :description, :price, :image, :category_id)
    end

    def set_photographer
      @photographer = Store.find_by(url: params[:photographer])
    end
end
