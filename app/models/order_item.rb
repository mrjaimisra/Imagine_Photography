class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

  def image_url
    current_item.image_url
  end

  def name
    current_item.name
  end

  def description
    current_item.description
  end

  def price
    current_item.price
  end

  def category_id
    current_item.category_id
  end

  def subtotal
    current_item.price * quantity
  end

  private

  def current_item
    Item.find(item_id)
  end
end
