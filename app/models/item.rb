class Item < ActiveRecord::Base
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items

  before_validation :default_image, :price_greater_than_zero, :category_id_not_zero

  validates :name,
            :description,
            :price,
            :image_url,
            :category_id, presence: true

  validates :name, uniqueness: true

  def default_image
    if self.image_url.nil? || self.image_url.empty?
      self.image_url = "Family-eating.jpg"
    end
  end

  def price_greater_than_zero
    if self.price.to_i <= 0
    errors.add(:price, "must be greater than zero.")
    end
  end

  def category_id_not_zero
    if self.category_id.to_i == 0
      errors.add(:category, "must be selected")
    end
  end
end