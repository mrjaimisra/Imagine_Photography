require "rails_helper"

RSpec.describe OrderItem, type: :model do
  let(:order_item) { Fabricate(:item) }

  context "a valid order item" do
    it "has an image url" do
      expect(order_item.image_url).to eq "hello.lpg"
    end

    it "has a name" do
      expect(order_item.name).to eq "Hamburger"
    end

    it "has a description" do
      expect(order_item.description).to eq "Nice and juicy."
    end

    it "has a price" do
      expect(order_item.price).to eq 12
    end

    it "has a category" do
      expect(order_item.category_id).to eq 1
    end
  end
end
