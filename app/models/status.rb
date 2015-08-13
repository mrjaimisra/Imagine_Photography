class Status < ActiveRecord::Base
  before_save :capitalize_name

  def capitalize_name
    name.capitalize!
  end
end
