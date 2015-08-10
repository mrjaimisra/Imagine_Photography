# Background: An existing user that has one previous order
# 
# As an authenticated user
# When I visit "/orders"
# Then I should see my past order
# And I should see a link to view that order

# And when I click that link
# Then I should see each item that was ordered with the quantity and line-item subtotals
# And I should see links to each item's show page
# And I should see the current status of the order (ordered, paid, cancelled, completed)
# And I should see the total price for the order
# And I should see the date/time that the order was submitted
# 
# If the order was completed or cancelled
# Then I should see a timestamp when the action took place
# 
# And if any of the items in the order were retired from the menu
# Then they should still be able to access the item page
# But they should not be able to add the item to their cart

require "rails_helper"

RSpec.describe "a user with one previous order", type: :feature do
  let!(:item) { create_item }

  before do
    register_user

    visit menu_path
    # add an item to cart
    within(".item-info") do
      expect(page).to have_content item.name
      click_button "Add to Cart"
    end

    sign_in

    visit cart_path
    click_link "Check Out"

    click_link "Sign Out"
  end


  context "is signed in" do
    before do
      sign_in
    end

    context "visits the orders page" do
      before do
        visit root_path
        click_link "Orders"
      end

      it "and sees order" do
        expect(current_path).to eq(user_orders_path(user_id: default_user.id))

        within(".orders") do
          expect(page).to have_content("Order Number")
          expect(page).to have_content("1")
        end
      end

      it "and sees a link to view a singular order" do
        within(".orders") do
          expect(page).to have_link("View")
          expect(page).to have_link("1")
        end
      end

      context "clicks the View Order link" do

        before do
          within(".orders") do
            click_link "View"
          end
        end

        it "and goes to the view single order page" do
          expect(current_path).to eq("/users/#{default_user.id}/orders/1")
        end

        it "and sees the order" do
          within(".page-title") do
            expect(page).to have_content("Order Number: 1")
          end
        end

        
      end

    end
  end
end
