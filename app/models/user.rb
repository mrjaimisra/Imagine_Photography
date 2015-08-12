class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  validates :username, presence: true, uniqueness: true
  validates :password, :street_name, :zipcode, :phone_number, presence: true

  enum role: %w(default admin)

  def destination
    "#{street_name}, #{zipcode}"
  end

  def origin
    "Union Station, Denver"
  end

  def directions
    GoogleDirections.new(origin, destination)
  end

  def valid_delivery?
    directions.distance_in_miles < 50
  end

  def delivery_time
    directions.drive_time_in_minutes
  end
end
