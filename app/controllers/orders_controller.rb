class OrdersController < ApplicationController

  def create
    user = current_user

    if user
      order = current_user.orders.new
      add_order_items(order)
      order.save

      flash[:success] = "Order placed! Dinners on the way!"
      redirect_to user_orders_path(user_id: current_user.id)
    else
      flash[:warning] = "Sign In to complete your order, Dinners almost ready!"
      redirect_to login_path
    end
  end

  def index
    @order = Order.all
  end

  private

  def add_order_items(order)
    cart.items.each do |cart_item|
      order.order_items.new(item: cart_item.item, quantity: cart_item.quantity)
    end
  end
end
