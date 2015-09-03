require "rails_helper"

RSpec.describe OrderPhoto, type: :model do
  let(:order_photo) { Fabricate(:photo) }

  context "a valid order photo" do
    it "has a name" do
      expect(order_photo.name).to eq order_photo.name
    end

    it "has a price" do
      expect(order_photo.price).to eq order_photo.price
    end
  end
end
