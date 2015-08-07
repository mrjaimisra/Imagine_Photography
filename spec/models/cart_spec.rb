require "rails_helper"

RSpec.describe "the cart", type: :model do
  it "exists" do
    expect(Cart).to be
  end

  context "method items" do
    it "returns an array of cart items" do
      item = create_item
      data = Hash.new(0)
      data[item.id] = 2
      cart = Cart.new(data)

      expect(cart.items.first).to be_a_kind_of CartItem
    end
  end

  context "method data" do
    it "returns a hash with the item id and quantity" do
      item = create_item
      id = item.id.to_s
      input_data = {}
      input_data[id] = 2
      cart = Cart.new(input_data)
      expect(cart.data).to eq({ id => 2 })
    end
  end

  context "method add item" do
    it "updates the data when an item is added" do
      item = create_item
      id = item.id.to_s
      cart = Cart.new(nil)

      cart.add_item(item)
      expect(cart.data).to eq({ id => 1 })

      cart.add_item(item)
      expect(cart.data).to eq({ id => 2 })
    end
  end
end
