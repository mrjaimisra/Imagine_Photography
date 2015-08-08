class Admin::UsersController < Admin::BaseController
  def create
    redirect_to admin_path
  end
end