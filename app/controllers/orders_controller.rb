require 'twilio-ruby'

class OrdersController < ApplicationController
  def create
    if current_user
      order = current_user.orders.new
      create_order(order)
      send_user_email
      send_photographer_email(order)
      empty_cart
      redirect_to order_path(order)
    else
      flash[:warning] = "Sign in to complete your order"
      redirect_to login_path
    end
  end

  def index
    current_user ? @orders = current_user.orders : authorization_error
  end

  def show
    @order = Order.find(params[:id])
    @status = @order.status
  end

  private

  def send_photographer_email(order)
    photos = order.order_photos.map { |order_photo| Photo.find(order_photo.photo_id) }
    store_ids = photos.map { |photo| photo.store_id }.uniq
    stores = store_ids.map { |id| Store.find(id) }
    stores.each do |store|
      NotificationsMailer.contact(
        name: "Imagine Photography",
        email: "#{store.email}",
        message: "You have received an order for some of your photos! You can
        view the order through the 'Orders' link after signing in at Imagine
        and should receive proceeds from the sale shortly."
      ).deliver_now
    end
  end

  def send_user_email
    NotificationsMailer.contact(
      name: "Imagine Photography",
      email: "#{current_user.email}",
      message: "Your photo order was placed successfully. Thank you for
      shopping at Imagine Photography!"
    ).deliver_now
  end

  def add_order_photos(order)
    cart.photos.each do |cart_photo|
      order.order_photos.new(photo: cart_photo.photo, quantity: cart_photo.quantity)
    end
  end

  def add_default_order_status(order)
    order.status = Status.find_or_create_by(name: "Ordered")
  end

  def create_order(order)
    add_order_photos(order)
    add_default_order_status(order)
    order.save
    order
  end

  def empty_cart
    session[:cart] = {}
    cart.empty
  end
end
