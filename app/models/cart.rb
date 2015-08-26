class Cart
  attr_accessor :data
  def initialize(data)
    @data = data || Hash.new
  end

  def photos
    data.map do |photo_id, quantity|
      photo = Photo.find(photo_id)
      CartPhoto.new(photo, quantity)
    end
  end

  def add_photo(photo)
    data[photo.id.to_s] ||= 0
    data[photo.id.to_s] += 1
  end

  def update_quantity(id, quantity)
    hash = { "increase" => 1, "decrease" => -1 }
    data[id] += hash[quantity]
  end

  def remove_from_cart(photo)
    data.delete(photo.id.to_s)
  end

  def total
    data.reduce(0) { |total, (id, quantity)|
      total += photo.find(id).price * quantity }
  end

  def empty
    @data = Hash.new
  end
end
