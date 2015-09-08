class PhotosController < ApplicationController
  def index
    @photos = Photo.paginate(page: params[:page]).order('created_at DESC')
  end

  def show
    @photo = Photo.find(params[:id])
  end

  private

  def photo_params
    params.require(:photo).permit(:name, :category, :description, :price)
  end
end
