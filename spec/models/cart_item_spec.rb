require "rails_helper"

RSpec.describe "the cart photo", type: :model do
  let(:photo) { Fabricate(:photo) }

  it "returns the name of the photo" do
    cart_photo = CartPhoto.new(photo)
    expect(cart_photo.name).to eq photo.name 
  end

  it "returns the quantity for a specific photo" do
    cart_photo = CartPhoto.new(photo, 2)
    expect(cart_photo.quantity).to eq 2
  end
end
