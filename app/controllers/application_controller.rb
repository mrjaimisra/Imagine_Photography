class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorize!

  helper_method :current_user, :cart, :current_admin
  add_flash_types :success, :info, :warning, :danger

  def cart
    @cart ||= Cart.new(session[:cart])
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # def current_admin?
  #   current_user && current_user.admin?
  # end

  def authorization_error
    render file: "/public/404_authorization.html", layout: false, status: 404
  end

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def authorize!
    unless authorized?
      redirect_to root_url, danger: "You're not authorized to visit this page!"
    end
  end

  private

    def authorized?
      current_permission.allow?(params[:controller], params[:action])
    end
end
