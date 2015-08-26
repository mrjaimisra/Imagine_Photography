class Photo < ActiveRecord::Base
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items

  before_validation :default_image,
                    :price_greater_than_zero,
                    :category_id_not_zero

  validates :name,
            :description,
            :price,
            :image_url,
            :category_id, presence: true

  # validates :name, uniqueness: true

  enum status: %w(active retired)

  def default_image
    if image_url.nil? || image_url.empty?
      self.image_url = "Family-eating.jpg"
    end
  end

  def price_greater_than_zero
    if price.to_i <= 0
      errors.add(:price, "must be greater than zero.")
    end
  end

  def category_id_not_zero
    if category_id.to_i == 0
      errors.add(:category, "must be selected")
    end
  end
end
