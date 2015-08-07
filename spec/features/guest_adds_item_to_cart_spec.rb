require "rails_helper"

RSpec.describe "the cart", type: :feature do
  context "a user that's not logged in" do
    it "can add items to the cart" do
      item = create_item
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

    it "can login and his/her items persist in the cart" do
      item = create_item
      visit menu_path

      within(".item-info") do
        expect(page).to have_content("Hamburger")
        3.times { click_button "Add to Cart" }
        expect(current_path).to eq menu_path
      end

      register_user
      sign_in
      expect(current_path).to eq menu_path

      click_link "Cart"

      within(".table-striped") do
        expect(page).to have_content("Hamburger")
        expect(page).to have_content("3")
      end
    end
  end

  context "a user that's logged in" do
    it "can add items to the cart" do
      item = create_item
      sign_in
      visit menu_path

      within(".item-info") do
        expect(page).to have_content("Hamburger")
        2.times { click_button "Add to Cart" }
        expect(current_path).to eq menu_path
      end

      click_link "Cart"

      within(".table-striped") do
        expect(page).to have_content("Hamburger")
        expect(page).to have_content("2")
      end
    end
  end

  context "a user that's logged in" do
    it "can add items to the cart" do
      item = create_item
      sign_in
      visit menu_path

      within(".item-info") do
        expect(page).to have_content("Hamburger")
        2.times { click_button "Add to Cart" }
        expect(current_path).to eq menu_path
      end

      click_link "Cart"

      within(".table-striped") do
        expect(page).to have_content("Hamburger")
        expect(page).to have_content("2")
      end
    end
  end
end
