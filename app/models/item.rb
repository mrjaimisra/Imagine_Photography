class Item < ActiveRecord::Base
  belongs_to :category
  validates :name,
            :description,
            :price,
            :image_url,
            :category_id, presence: true
end
