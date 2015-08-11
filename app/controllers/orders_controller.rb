class OrdersController < ApplicationController

  def create
    if current_user
      order = current_user.orders.new
      add_order_items(order)
      order.status_id = 1
      send_text_message if current_user.phone_number
      order.save

      session[:cart] = {}
      cart.empty

      flash[:success] = "Order placed! Dinners on the way!"
      redirect_to orders_path
    else
      flash[:warning] = "Sign In to complete your order, Dinners almost ready!"
      redirect_to login_path
    end
  end

  def index
    if current_user
      @orders = current_user.orders
    else
      authorization_error
    end
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
end
