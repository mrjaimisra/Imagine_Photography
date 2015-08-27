require "rails_helper"

RSpec.describe "the cart", type: :model do
  it "exists" do
    expect(Cart).to be
  end

  context "method photos" do
    let(:photo) { Fabricate(:photo) }

    it "returns an array of cart photos" do
      data = Hash.new(0)
      data[photo.id] = 2
      cart = Cart.new(data)

      expect(cart.photos.first).to be_a_kind_of CartPhoto
    end
  end

  context "method data" do
    let(:photo) { Fabricate(:photo) }

    it "returns a hash with the photo id and quantity" do
      id = photo.id.to_s
      input_data = {}
      input_data[id] = 2
      cart = Cart.new(input_data)
      expect(cart.data).to eq({ id => 2 })
    end
  end

  context "method add photo" do
    let(:photo) { Fabricate(:photo) }

    it "updates the data when a photo is added" do
      id = photo.id.to_s
      cart = Cart.new(nil)

      cart.add_photo(photo)
      expect(cart.data).to eq({ id => 1 })

      cart.add_photo(photo)
      expect(cart.data).to eq({ id => 2 })
    end
  end
end
