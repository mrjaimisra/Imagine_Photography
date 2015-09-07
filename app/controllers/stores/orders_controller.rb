class Stores::OrdersController < StoresController
  before_action :set_photographer, only: [:index, :show]

  def index
    @orders = Order.joins(:photos)
                   .where(photos: { store_id: @photographer.id })
  end

  def show
    @order = Order.find_by(id: params[:id])
    @photos = @order.photos.where(store_id: @photographer.id)
    @total_price = @photos.sum(:price)
  end

  private

    def set_photographer
      @photographer = Store.find_by(url: params[:photographer])
    end
end
