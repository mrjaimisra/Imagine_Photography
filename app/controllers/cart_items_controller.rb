class CartItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def create
    redirect_to menu_path
  end
end