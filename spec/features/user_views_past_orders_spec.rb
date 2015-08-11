# Background: An existing user that has multiple orders
#
# As an Authenticated User
# When I visit "/orders"
# Then I should see all orders belonging to me
#
# As A Visitor
# When I visit "/orders"
# I should get a 404

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
