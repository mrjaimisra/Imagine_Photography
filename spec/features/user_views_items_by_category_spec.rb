require "rails_helper"

RSpec.describe "the category view", type: :feature do
  context "user visits /menu/category" do
    let!(:item) { Item.create(name: "Breakfast burrito",
                              description: "delicious",
                              price: 5, image_url: test_image_url,
                              category_id: 1) }

    let!(:category) { Category.create(name: "breakfast") }

    it "views the items in the lunch category" do
      visit "/menu/breakfast"
      expect(current_path).to  eq(category_path(category.name))

      within(".category-view") do
        expect(page).to have_content("#{category.name}")
      end

      within(".items-list") do
        within("#item-box") do
          expect(page).to have_link("#{item.name}")
          expect(page).to have_content("#{item.description}")
          expect(page).to have_content("#{item.price}")
          expect(page).to have_css("img[src*='#{item.image_url}']")
        end
      end
    end

    it "redirects to the item" do
      visit "/menu/breakfast"

      within(".items-list") do
        within("#item-box") do
          click_link("#{item.name}")
          expect(current_path).to eq item_path(item)
        end
      end
    end
  end
end
