require "rails_helper"

RSpec.describe "the category view", type: :feature do
  context "user visits a category page" do
    let!(:item) { Item.create(name: "Breakfast burrito",
                              description: "delicious",
                              price: 5, image_url: test_image_url,
                              category_id: 1) }

    let!(:category) { Category.create(name: "breakfast") }
    let!(:other_category) { Category.create(name: "lunch") }


    it "displays the correct path in the address bar" do
      visit "menu/#{category.name}"
      expect(current_path).to eq("/menu/breakfast")
    end

    it "views the items in the category" do
      visit "menu/#{category.name}"

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

    it "cannot view items in other categories" do
      visit "menu/#{other_category.name}"

      within(".items-list") do
        within("#item-box") do
          expect(page).to_not have_link("#{item.name}")
          expect(page).to_not have_content("#{item.description}")
          expect(page).to_not have_content("#{item.price}")
          expect(page).to_not have_css("img[src='#{item.image_url}']")
        end
      end
    end

    it "redirects to an items show page when item name is clicked" do
      visit "menu/#{category.name}"

      within(".items-list") do
        within("#item-box") do
          click_link("#{item.name}")
          expect(current_path).to eq meal_path(item.id)
        end
      end
    end
  end
end
