require "rails_helper"

# Background: An existing user and a cart with items
#
# As a visitor
# When I visit "/cart"
# And I click "Checkout"
# Then I should be required to login
#
# When I am logged in
# And I visit "/cart"
# And I click "Checkout"
# Then the order should be placed
# And my current page should be "/orders"
# And I should see a message "Order was successfully placed"
# And I should see the order I just placed in a table

RSpec.describe "a user with a non empty cart", type: :feature do

  before do
    item = create_item
    visit menu_path

    # add an item to cart
    within(".item-info") do
      expect(page).to have_content item.name
      click_button "Add to Cart"
    end
  end


  context "who has an account" do

    before do
      register_user
    end

    context "and is not signed in" do

      context "and checks out" do

        before do
          visit cart_path
          click_link "Check Out"
        end

        it "is required to login" do
          expect(current_path).to eq(login_path)

          within(".alert") do
            expect(page).to have_content("Sign In to complete your order, Dinners almost ready!")
          end
          within(".login-form") do
            expect(page).to have_button("Sign In")
          end
        end

      end

      context "and is signed in" do

        before do
          sign_in
        end

        context "and checks out" do

          before do
            visit cart_path
            click_link "Check Out"
          end

          it "go to the orders page" do
            expect(current_path).to eq(orders_path)
          end
        end
      end

    end
  end
end
