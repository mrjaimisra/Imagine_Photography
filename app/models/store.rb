class Store < ActiveRecord::Base
  has_many :photos

  before_validation :generate_url

  def generate_url
    self.url = name.parameterize
  end
end
