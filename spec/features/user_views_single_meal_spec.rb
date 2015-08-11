require "rails_helper"

RSpec.describe "the item view", type: :feature do
  context "an existing item" do
    let!(:item) { Fabricate(:item) }

    it "views a single item" do
      visit menu_path

      within(".item-info") do
        click_link item.name
      end

      expect(current_path).to eq meal_path(item.id)

      within(".item-show") do
        within(".item-info") do
          expect(page).to have_content item.name
          expect(page).to have_content item.description
          expect(page).to have_content item.price
        end

        within(".thumbnail") do
          expect(page).to have_css("img[src*='#{item.image_url}']")
        end
      end
    end
  end
end
