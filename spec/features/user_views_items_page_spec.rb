require "rails_helper"

RSpec.describe "the items view", type: :feature do
  context "a user visits the items view" do
    let!(:item) { Fabricate(:item) }

    it "displays all items" do
      visit menu_path

      within(".item-box") do
        expect(page).to have_content item.name
      end
    end

    it "views an items name, description, price and image" do
      visit menu_path

      within(".item-box") do
        expect(page).to have_content item.name
        expect(page).to have_content item.description
        expect(page).to have_content item.price
        expect(page).to have_css "img[src*='#{item.image_url}']"
      end
    end
  end
end
