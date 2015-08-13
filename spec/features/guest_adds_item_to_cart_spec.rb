require "rails_helper"

RSpec.describe "the cart", type: :feature do
  context "a user that's not logged in" do
    let!(:item) { Fabricate(:item) }
    let!(:user) { Fabricate(:user) }

    it "can add items to the cart" do
      visit menu_path

      within(".item-info") do
        expect(page).to have_content item.name
        3.times { click_button "Add to Cart" }
        expect(current_path).to eq menu_path
      end

      click_link "Cart"
      expect(current_path).to eq cart_path

      within(".table-striped") do
        expect(page).to have_content item.name
        expect(page).to have_content "3"
      end
    end

    it "can login and his/her items persist in the cart" do
      visit menu_path

      within(".item-info") do
        expect(page).to have_content item.name
        3.times { click_button "Add to Cart" }
        expect(current_path).to eq menu_path
      end

      sign_in(user)
      expect(current_path).to eq menu_path

      click_link "Cart"

      within(".table-striped") do
        expect(page).to have_content item.name
        expect(page).to have_content "3"
      end
    end
  end

  context "a user that's logged in" do
    let!(:item) { Fabricate(:item) }
    let!(:user) { Fabricate(:user) }

    it "can add items to the cart" do
      sign_in(user)
      visit menu_path

      within(".item-info") do
        expect(page).to have_content item.name
        2.times { click_button "Add to Cart" }
        expect(current_path).to eq menu_path
      end

      click_link "Cart"

      within(".table-striped") do
        expect(page).to have_content item.name
        expect(page).to have_content "2"
      end
    end
  end

  context "a user that's logged in" do
    let!(:item) { Fabricate(:item) }
    let!(:user) { Fabricate(:user) }

    it "can add items to the cart" do
      sign_in(user)
      visit menu_path

      within(".item-info") do
        expect(page).to have_content item.name
        2.times { click_button "Add to Cart" }
        expect(current_path).to eq menu_path
      end

      click_link "Cart"

      within(".table-striped") do
        expect(page).to have_content item.name
        expect(page).to have_content "2"
      end
    end
  end
end
