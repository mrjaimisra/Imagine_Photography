require "rails_helper"

RSpec.describe "the item view", type: :feature do
  context "an existing item" do
    it "views a single item" do
      Item.create(name: "Hamburger and fries", description: "delicious", price: 12)
      visit items_path

      click_link "Hamburger and fries"
      expect(current_path).to eq item_path(item)

      within(".item-show") do
        expect(page).to have_content "Hamburger and fries"
        expect(page).to have_content "delicious"
        expect(page).to have_content "12"
      end
    end
  end
end
