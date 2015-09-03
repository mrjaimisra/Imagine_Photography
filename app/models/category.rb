class Category < ActiveRecord::Base
  has_many :photos
  validate :check_for_special_characters
  validates :name, presence: true, uniqueness: true

  before_save :capitalize_name

  def to_param
    name.downcase.parameterize
  end

  def check_for_special_characters
    if name.to_s.match(/[^a-zA-Z0-9]+/)
      errors.add(:alphanumeric, "cannot have special characters")
    end
  end

  def capitalize_name
    name.capitalize!
  end
end
