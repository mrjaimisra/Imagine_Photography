class OrderPhoto < ActiveRecord::Base
  belongs_to :order
  belongs_to :photo

  def name
    current_photo.name
  end

  def price
    current_photo.price
  end

  private

  def current_photo
    Photo.find(photo_id)
  end
end
