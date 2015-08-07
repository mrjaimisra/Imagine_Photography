require "rails_helper"

RSpec.describe "the cart", type: :feature do
  context "a user that's not logged in with an empty cart" do
    it "can add items to the cart" do
      item = Item.create(name: "Hamburger", description: "So delicious.", price: 12, image_url: test_image_url, category_id: 2)
      visit menu_path

      within(".item-info") do
        expect(page).to have_content("Hamburger")
        3.times { click_button "Add to Cart" }
        expect(current_path).to eq menu_path
      end

      click_link "Cart"
      expect(current_path).to eq cart_path

      within(".table-striped") do
        expect(page).to have_content("Hamburger")
        expect(page).to have_content("3")
      end
    end
  end
end
