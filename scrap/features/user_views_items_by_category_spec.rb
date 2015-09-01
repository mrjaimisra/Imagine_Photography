require "rails_helper"

RSpec.describe "the category view", type: :feature do
  context "user visits a category page" do
    let!(:category) { Category.create(name: "Breakfast") }
    let!(:item) {
      Item.create(
        name:        "Breakfast burrito",
        description: "delicious",
        price:       5,
        image_url:   test_image_url,
        category_id: category.id
      )
    }

    let!(:other_category) { Category.create(name: "Lunch") }
    let!(:other_item) {
      Item.create(
        name:        "Hamburger",
        description: "Not bad for road kill",
        price:       8,
        image_url:   test_image_url,
        category_id: other_category.id
      )
    }

    it "displays the correct path in the address bar" do
      visit "photos/#{category.name}"
      expect(current_path).to eq("/photos/Breakfast")
    end

    it "views the photos in the category" do
      visit "photos/#{category.name}"

      within(".page-title") do
        expect(page).to have_content("#{category.name.capitalize}")
      end

      within(".item-box") do
        expect(page).to have_link("#{item.name}")
        expect(page).to have_content("#{item.description}")
        expect(page).to have_content("#{item.price}")
        expect(page).to have_css("img[src*='#{item.image_url}']")
      end
    end

    it "cannot view photos in other categories" do
      visit "photos/#{other_category.name}"

      within(".item-box") do
        expect(page).to_not have_link("#{item.name}")
        expect(page).to_not have_content("#{item.description}")
        expect(page).to_not have_content("#{item.price}")
      end
    end

    it "redirects to an photos show page when item name is clicked" do
      visit "photos/#{category.name}"

      within(".item-box") do
        click_link("#{item.name}")
        expect(current_path).to eq meal_path(item.id)
      end
    end
  end
end
