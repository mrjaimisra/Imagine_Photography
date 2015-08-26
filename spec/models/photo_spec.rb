require "rails_helper"

RSpec.describe "the photo", type: :model do
  let(:photo) { Fabricate(:photo) }

  context "a photo" do
    it "is valid" do
      expect(photo).to be_valid
    end

    it "is invalid without a name" do
      photo.name = nil
      expect(photo).to_not be_valid
    end

    it "is invalid without a description" do
      photo.description = nil
      expect(photo).to_not be_valid
    end

    it "is invalid without a price" do
      photo.price = nil
      expect(photo).to_not be_valid
    end

    it "defaults to an image url when none provided" do
      photo.update_attributes(image_url: nil)
      expect(photo.image_url).to eq("Family-eating.jpg")
    end

    it "is invalid without a category id" do
      photo.category_id = nil
      expect(photo).to_not be_valid
    end

    it "knows if photo was retired" do
      photo.status = 1
      expect(photo.retired?).to be true
    end

    it "knows if photo was active" do
      photo.status = 0
      expect(photo.active?).to be true
    end
  end
end

