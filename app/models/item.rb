class Item < ActiveRecord::Base
  validates :name, :description, :price, :image_url, :category_id, presence: true
end
