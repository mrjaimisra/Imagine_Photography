class Cart
  attr_accessor :data
  def initialize(data)
    @data = data || Hash.new
  end

  def items
    data.map do |item_id, quantity|
      item = Item.find(item_id)
      CartItem.new(item, quantity)
    end
  end

  def add_item(item)
    data[item.id.to_s] ||= 0
    data[item.id.to_s] += 1
  end

  def update_quantity(id, quantity)
    hash = { "increase" => 1, "decrease" => -1 }
    data[id] += hash[quantity]
  end

  def remove_from_cart(item)
    data.delete(item.id.to_s)
  end

  def total
    data.reduce(0) { |total, (id, quantity)|
      total += Item.find(id).price * quantity }
  end
end
