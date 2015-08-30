class Photo < ActiveRecord::Base
  belongs_to :category
  belongs_to :store
  has_many :order_photos
  has_many :orders, through: :order_photos

  has_attached_file :image, styles: { xlarge: "1200x1200",
                                      large: "800x800",
                                      medium: "300x300#",
                                      thumb: "150x150#" },
                                      default_url: "/images/beach_van.jpg"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  before_validation :default_image,
                    :price_greater_than_zero,
                    :category_id_not_zero

  validates :name,
            :description,
            :price,
            :image_file_name,
            :store_id,
            :category_id, presence: true

  enum status: %w(active retired)

  def default_image
    if image_url.nil? || image_url.empty?
      self.image_url = "beach_van.jpg"
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
