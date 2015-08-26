class OrderPhoto < ActiveRecord::Base
  belongs_to :order
  belongs_to :photo

  def image_url
    current_photo.image_url
  end

  def name
    current_photo.name
  end

  def description
    current_photo.description
  end

  def price
    current_photo.price
  end

  def category_id
    current_photo.category_id
  end

  def subtotal
    current_photo.price * quantity
  end

  private

  def current_photo
    Photo.find(photo_id)
  end
end
