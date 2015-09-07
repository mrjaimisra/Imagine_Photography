module Stores::OrdersHelper
  def order_total_price(order)
    order.photos.where(photos: { store_id: @photographer.id }).sum(:price)
  end
end
