class Item < ActiveRecord::Base
  validates :name, :description, :price, presence: true
end
