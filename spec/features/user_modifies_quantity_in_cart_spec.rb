require "rails_helper"

RSpec.describe "the cart quantity", type: :feature do
  context "a user with items in the cart" do
    let!(:item) { Fabricate(:item) }
    let!(:user) { Fabricate(:user) }

    it "adds items to the cart" do
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
        click_button "+"
      end

      expect(page).to have_content "3"
    end

    it "decreases quantity of items from the cart" do
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
        click_button "-"
      end

      expect(page).to have_content "1"
    end

    it "displays total cost" do
      sign_in(user)
      visit menu_path

      2.times { click_button "Add to Cart" }
      click_link "Cart"

      within(".total") do
        expect(page).to have_content "Total: $24"
      end
    end

    it "displays the subtotal" do
      sign_in(user)
      visit menu_path

      4.times { click_button "Add to Cart" }
      click_link "Cart"

      within(".subtotal") do
        expect(page).to have_content "$48"
      end
    end

    it "removes items from the cart" do
      sign_in(user)
      visit menu_path
      2.times { click_button "Add to Cart" }
      click_link "Cart"

      click_link "Remove"
      within(".alert-success") do
        expect(page).to have_content "Successfully removed #{item.name} from your cart."
      end

      within(".table-striped") do
        expect(page).to_not have_content item.name
      end

      click_link "#{item.name}"
      expect(current_path).to eq meal_path(item)
    end

    it "removes the item if the quantity is zero" do
      sign_in(user)
      visit menu_path
      2.times { click_button "Add to Cart" }
      click_link "Cart"

      2.times { click_button "-" }

      within(".table-striped") do
        expect(page).to_not have_content item.name
      end
    end
  end
end
