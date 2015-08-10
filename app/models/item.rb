class Item < ActiveRecord::Base
  has_attached_file :avatar, styles: { medium: "400X400>", thumb: "100X100>" }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
  belongs_to :category
  validates :name,
            :description,
            :price,
            :image_url,
            :category_id, presence: true
end
