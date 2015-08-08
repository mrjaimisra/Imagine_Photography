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
  context "who has an account" do
    context "and is not signed in" do

      attr_reader :item

      before do
        register_user
        @item = create_item
      end

      it "required to login before checking out" do
        visit menu_path

        # add an item to cart
        within(".item-info") do
          expect(page).to have_content item.name
          click_button "Add to Cart"
        end

        visit cart_path
        click_link "Check Out"

        expect(current_path).to eq(login_path)

        within(".alert") do
          expect(page).to have_content("Sign In to complete your order, Dinners almost ready!")
        end
        within(".login-form") do
          expect(page).to have_button("Sign In")
        end
      end

    end
  end
end
