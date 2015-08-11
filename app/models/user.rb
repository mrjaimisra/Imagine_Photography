class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  validates :username, presence: true, uniqueness: true
  validates :password, :street_name, :zipcode, :phone_number, presence: true

  enum role: %w(default admin)

  def valid_delivery?
    destination = "#{street_name}, #{zipcode}"
    check_validity(destination) < 50
  end

  def check_validity(destination)
    origin = "1510 Blake Street, Denver"
    directions = GoogleDirections.new(origin, destination)
    directions.distance_in_miles
  end
end
