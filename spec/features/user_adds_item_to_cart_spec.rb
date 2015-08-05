require "rails_helper"

RSpec.describe "a user adds and item to their cart" do
  context "not logged in user with an empty cart" do
    let!(:item) { Item.create(name: "Cake",
                              description: "Sticky sweet",
                              price: 100,
                              image_url: test_image_url,
                              category_id: 2) }

    xit "lets a user add an item" do
      visit menu_path
      click_button "Add to Cart"
      expect(current_path).to eq(menu_path)

      click_link "Cart"

      expect(page).to have_content("Cake")
      expect(page).to have_content("Sticky sweet")
      expect(page).to have_content(100)
      expect(page).to have_content(test_image_url)
    end
  end
end
