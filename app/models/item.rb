class Item < ActiveRecord::Base
  validates :name, :description, :price, :image_url, presence: true
end
