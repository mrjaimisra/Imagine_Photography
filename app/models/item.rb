class Item < ActiveRecord::Base
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items

  before_validation :default_image

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
end
