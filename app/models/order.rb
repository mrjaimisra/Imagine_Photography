class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :status

  has_many :order_photos, autosave: true
  has_many :photos, through: :order_photos

  def customer_name
    User.find(user_id).name
  end

  def total
    order_photos.inject(0) do |total, order_photo|
      total += Photo.find(order_photo.photo_id).price
    end
  end

  # def status_name(status_id)
  #   Status.find(status_id).name
  # end
end
