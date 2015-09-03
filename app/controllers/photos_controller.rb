class PhotosController < ApplicationController
  def index
    @photos = Photo.paginate(page: params[:page]).order('created_at DESC')
  end

  def show
    @photo = Photo.find(params[:id])
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
      redirect_to edit_photo_path(@photo)
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
    params.require(:photo).permit(:name,
                                 :category,
                                 :description,
                                 :price)
  end
end
