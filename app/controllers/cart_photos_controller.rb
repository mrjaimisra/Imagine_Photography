class CartPhotosController < ApplicationController
  def index
    @cart_photos = cart.photos
  end

  def create
    photo = Photo.find(params[:photo_id])
    cart.add_photo(photo)
    session[:cart] = cart.data
    redirect_to cart_path
  end

  def update
    cart.update_quantity(params[:id], params[:quantity])
    remove_and_render_flash(params[:id]) if cart.data[params[:id]] == 0
    redirect_to :back
  end

  def destroy
    remove_and_render_flash(params[:id])
    redirect_to :back
  end


  private

  def remove_and_render_flash(id)
    photo = Photo.find_by(id: id)
    cart.remove_from_cart(photo)
    flash[:success] = "Successfully removed #{photo.name} from your cart."
  end

  # def delivery_flash?
  #   unless current_user.valid_delivery?
  #     flash.now[:warning] = "We unfortunately do not deliver in your area."
  #   end
  # end
end
