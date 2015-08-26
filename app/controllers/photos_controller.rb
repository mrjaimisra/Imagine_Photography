class PhotosController < ApplicationController
  def index
    @items = Photo.all
  end

  def show
    @item = Photo.find(params[:id])
  end
end
