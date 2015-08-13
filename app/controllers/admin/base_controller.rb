class Admin::BaseController < ApplicationController
  before_action :require_admin

  def require_admin
    authorization_error unless current_admin?
  end
end
