class CartItemsController < ApplicationController
  def index
    @cart_items = cart.items
    # will delete in fabrication implementation
    # current_user.zipcode = "22630" if current_user
    # current_user.street_name = "2717 Glenwood Drive" if current_user
    current_user.valid_delivery? if current_user
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
    link = "<a href='/meals/#{params[:id]}'>#{item.name}</a>"
    flash[:success] =
      %[Successfully removed #{link} from your cart.]

    cart.remove_from_cart(item)
  end
end
