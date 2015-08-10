class CartItemsController < ApplicationController
  def index
    @cart_items = cart.items
    check_zipcode if current_user
  end

  def create
    item = Item.find(params[:item_id])
    cart.add_item(item)
    session[:cart] = cart.data
    redirect_to :back
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
    item = Item.find_by(id: id)
    flash[:success] = %[Successfully removed <a href="/meals/#{params[:id]}">
    #{item.name}</a> from your cart.]
    cart.remove_from_cart(item)
  end

  def check_zipcode
    uri = URI("https://www.zipcodeapi.com/rest/0B3bMb02Ei5MI1SgnRzXhOJPZkY9V7kWIo7uz8xdqC09DTp1KZZ1NIRN2QXYXiVG/distance.json/80303/#{current_user.zipcode}/mile")
    distance = Net::HTTP.get(uri)
    if Location.success_or_fail(distance)
      flash.now[:success] = "We deliver in your area!"
    else
      flash.now[:warning] = "We unfortunately do not deliver in your area."
    end
  end
end
