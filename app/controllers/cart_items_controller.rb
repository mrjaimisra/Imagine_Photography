class CartItemsController < ApplicationController
  def index
    @cart_items = cart.items
  end

  def create
    item = Item.find(params[:item_id])
    cart.add_item(item)
    session[:cart] = cart.data
    redirect_to :back
  end

  def update
    cart.update_quantity(params[:id], params[:quantity])
    redirect_to :back
  end

  def destroy
    item = Item.find_by(id: params[:id])
    flash[:success] = "Successfully removed #{item.name} from your cart."
    cart.remove_from_cart(item)
    redirect_to :back
  end
end
