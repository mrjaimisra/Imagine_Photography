class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :cart, :current_admin

  def cart
    @cart ||= Cart.new(session[:cart])
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def authorization_error
    render file: "/public/404_authorization.html", layout: false, status: 404
  end

  def current_store
    @current_store ||= Store.find_by(url: params[:photographer]) if params[:photographer]
  end
end
