class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.all
    @statuses = Status.all
  end

  def show
    status = Status.find_by(name: params[:id])
    @orders = Order.where(status_id: status.id)
    @statuses = Status.all
    render :index
  end

  def update
    @order = Order.find_by(id: params[:id])
    @order.status_id = (params[:order][:status]).to_i
    @order.save
    redirect_to admin_orders_path
  end
end