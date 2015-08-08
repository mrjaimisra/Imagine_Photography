class OrdersController < ApplicationController
  def create
    flash[:warning] = "Sign In to complete your order, Dinners almost ready!"
    redirect_to login_path
  end
end
