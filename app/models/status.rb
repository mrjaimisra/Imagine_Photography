class Status < ActiveRecord::Base
  has_many :orders

  before_save :capitalize_name

  def capitalize_name
    name.capitalize!
  end
end
