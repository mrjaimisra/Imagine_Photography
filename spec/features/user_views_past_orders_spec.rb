require "rails_helper"

RSpec.describe "a user with past orders", type: :feature do
  let!(:item) { Fabricate(:item) }
  let!(:user) { Fabricate(:user) }

  before do
    sign_in(user)

    visit menu_path
    within(".item-info") do
      expect(page).to have_content item.name
      3.times { click_button "Add to Cart" }
    end
    visit cart_path
    click_link "Check Out"

    visit menu_path
    within(".item-info") do
      expect(page).to have_content item.name
      click_button "Add to Cart"
    end
    visit cart_path
    click_link "Check Out"

    click_link "Sign Out"
  end

  context "and is logged in" do
    before do
      sign_in(user)
    end

    context "goes to the orders page" do
      before do
        visit orders_path
      end

      it "can see past orders" do
        within(".orders") do
          expect(page).to have_content("Order Number")
          expect(page).to have_content("Total")
          expect(page).to have_content("Order Date")
          expect(page).to have_link("1")
          expect(page).to have_link("2")
          expect(page).to have_content("36")
          expect(page).to have_content("12")
        end
      end
    end

  end

  context "who is not signed in" do
    context "goes to the orders page" do
      before do
        visit orders_path
      end

      it "sees 404 page" do
        expect(page).to have_content("Sorry but Dinner is not here!")
        expect(page).to have_link("But I know where to get it!")
      end
    end
  end
end
