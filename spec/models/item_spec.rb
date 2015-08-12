require "rails_helper"

RSpec.describe "the item", type: :model do
  let(:item) { Fabricate(:item) }

  context "an item" do
    it "is valid" do
      expect(item).to be_valid
    end

    it "is invalid without a name" do
      item.name = nil
      expect(item).to_not be_valid
    end

    it "is invalid without a description" do
      item.description = nil
      expect(item).to_not be_valid
    end

    it "is invalid without a price" do
      item.price = nil
      expect(item).to_not be_valid
    end

    it "defaults to an image url when none provided" do
      item.update_attributes(image_url: nil)
      expect(item.image_url).to eq("Family-eating.jpg")
    end

    it "is invalid without a category id" do
      item.category_id = nil
      expect(item).to_not be_valid
    end

    it "knows if item was retired" do
      item.status = 1
      expect(item.retired?).to be true
    end

    it "knows if item was active" do
      item.status = 0
      expect(item.active?).to be true
    end
  end
end

