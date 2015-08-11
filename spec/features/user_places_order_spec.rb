require "rails_helper"

RSpec.describe "a user with a non empty cart", type: :feature do
  let!(:item) { Fabricate(:item) }
  let!(:user) { Fabricate(:user) }

  before do
    visit menu_path

    within(".item-info") do
      expect(page).to have_content item.name
      3.times { click_button "Add to Cart" }
    end
  end

  context "who has an account" do
    context "and is not signed in" do
      context "and checks out" do

        before do
          visit cart_path
          click_link "Check Out"
        end

        it "is required to login" do
          expect(current_path).to eq login_path

          within(".alert") do
            expect(page).to have_content(
                    "Sign In to complete your order, Dinners almost ready!")
          end
          within(".login-form") do
            expect(page).to have_button "Sign In"
          end
        end
      end
    end

    context "and is signed in" do
      before do
        sign_in(user)
      end

      context "and checks out" do
        before do
          visit cart_path
          click_link "Check Out"
        end

        it "go to the orders page" do
          expect(current_path).to eq user_orders_path(user_id: user.id)
        end

        it "sees order confirmation message" do
          within(".alert") do
            expect(page).to have_content "Order placed! Dinners on the way!"
          end
        end

        it "sees order" do
          within(".page-title") do
            expect(page).to have_content "#{user.username}'s Order's"
          end

          within(".orders") do
            expect(page).to have_content "Order Number"
            expect(page).to have_content "1"
            expect(page).to have_content "Total"
            expect(page).to have_content (item.price * 3).to_s
          end
        end
      end
    end
  end
end
