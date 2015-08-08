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
end
