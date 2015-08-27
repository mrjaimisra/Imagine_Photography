require "rails_helper"

RSpec.describe "the photos view", type: :feature do
  context "a user visits the photos view" do
    let!(:item) { Fabricate(:item) }

    it "displays all photos" do
      visit menu_path

      within(".item-box") do
        expect(page).to have_content item.name
      end
    end

    it "views an photos name, description, price and image" do
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
