require "rails_helper"

RSpec.describe "the cart item", type: :model do
  it "returns the name of the item" do
    item = create_item
    cart_item = CartItem.new(item)
    expect(cart_item.name).to eq "Hamburger"
  end

  it "returns the quantity for a specific item" do
    item = create_item
    cart_item = CartItem.new(item, 2)
    expect(cart_item.quantity).to eq 2
  end
end
