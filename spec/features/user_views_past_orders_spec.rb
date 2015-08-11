require "rails_helper"

RSpec.describe "a user with past orders", type: :feature do
  let!(:item) { create_item }

  before do
    register_and_sign_in_user

    visit menu_path
    # creating 2 orders will refactor this to spec helper
    within(".item-info") do
      expect(page).to have_content item.name
      click_button "Add to Cart"
      click_button "Add to Cart"
      click_button "Add to Cart"
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
      sign_in
    end

    context "goes to the orders page" do
      before do
        visit user_orders_path(user_id: default_user.id)
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
        visit user_orders_path(user_id: default_user.id)
      end

      it "sees 404 page" do
        expect(page).to have_content("Sorry but Dinner is not here!")
        expect(page).to have_link("But I know where to get it!")
      end
    end
  end
end
