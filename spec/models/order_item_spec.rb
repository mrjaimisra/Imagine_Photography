require "rails_helper"

RSpec.describe OrderPhoto, type: :model do
  let(:order_photo) { Fabricate(:photo) }

  context "a valid order photo" do
    it "has an image url" do
      expect(order_photo.image_url).to eq "hello.lpg"
    end

    it "has a name" do
      expect(order_photo.name).to eq order_photo.name 
    end

    it "has a description" do
      expect(order_photo.description).to eq order_photo.description 
    end

    it "has a price" do
      expect(order_photo.price).to eq order_photo.price 
    end

    it "has a category" do
      expect(order_photo.category_id).to eq order_photo.category_id 
    end
  end
end
