require "rails_helper"

RSpec.describe "a user with one previous order", type: :feature do
  let!(:item) { create_item }
  let!(:status) { Status.create(name: "Completed") }

  before do
    register_user

    visit menu_path
    
    within(".item-info") do
      expect(page).to have_content item.name
      click_button "Add to Cart"
      click_button "Add to Cart"
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

        it "and sees the order number" do
          within(".page-title") do
            expect(page).to have_content("Order Number: 1")
          end
        end

        it "and sees the order item" do
          within(".order") do
            expect(page).to have_content(item.name)
            expect(page).to have_content(item.price)
            #subtotal
            expect(page).to have_content((item.price * 3).to_s)
            expect(page).to have_content("3")
            expect(page).to have_link("View")
          end
        end

        it "and sees the order total" do
          within(".total") do
            expect(page).to have_content((item.price * 3).to_s)
          end
        end

        it "and sees the date and time order was placed" do
          within(".order") do
            expect(page).to have_content("Last Updated")
          end
        end

        it "and sees the current status" do
          within(".order") do
            expect(page).to have_content("Status")
            expect(page).to have_content("Completed")
          end
        end

      end
    end
  end
end

