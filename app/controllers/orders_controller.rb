class OrdersController < ApplicationController

  def create
    if current_user
      create_order
      empty_cart
      notify_user
      redirect_to orders_path
    else
      flash[:warning] = "Sign In to complete your order, Dinners almost ready!"
      redirect_to login_path
    end
  end

  def index
    @orders = current_user.orders if current_user
    authorization_error unless current_user
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def add_order_items(order)
    cart.items.each do |cart_item|
      order.order_items.new(item: cart_item.item, quantity: cart_item.quantity)
    end
  end

  def send_text_message
    send_to = current_user.phone_number
    twilio_phone_number = "7205063562"
    @twilio_client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token

    @twilio_client.account.messages.create(
      from: "+1#{twilio_phone_number}",
      to: "+1#{send_to}",
      body: "Your order is on it's way! - Dinner's Ready"
    )
  end

  def create_order
    order = current_user.orders.new
    add_order_items(order)
    order.status_id = 1
    order.save
  end

  def empty_cart
    session[:cart] = {}
    cart.empty
  end

  def notify_user
    send_text_message if current_user.phone_number
    flash[:success] = "Order placed! Dinners on the way!"
  end
end
