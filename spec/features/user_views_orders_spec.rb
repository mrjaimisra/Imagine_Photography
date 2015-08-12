require "rails_helper"

RSpec.describe "a user with one previous order", type: :feature do
  let!(:item) { Fabricate(:item) }
  let!(:user) { Fabricate(:user) }
  let!(:status) { Status.create(name: "Completed") }

  before do
    sign_in(user)

    within(".item-info") do
      expect(page).to have_content item.name
      3.times { click_button "Add to Cart" }
    end

    visit cart_path
    click_link "Check Out"
  end

  context "is signed in" do
    context "visits the orders page" do
      before do
        click_link "Orders"
      end

      it "views the order" do
        expect(current_path).to eq orders_path

        within(".orders") do
          expect(page).to have_content "Order Number"
          expect(page).to have_content "1"
        end
      end

      it "views a link to view a singular order" do
        within(".orders") do
          expect(page).to have_link "View"
          expect(page).to have_link "1"
        end
      end

      context "clicks the View Order link" do
        before do
          within(".orders") do
            click_link "View"
          end
        end

        it "goes to the view single order page" do
          expect(current_path).to eq "#{orders_path}/1"
        end

        it "views the order number" do
          within(".page-title") do
            expect(page).to have_content "Order Number: 1"
          end
        end

        it "views the order item" do
          within(".order") do
            expect(page).to have_content item.name
            expect(page).to have_content item.price
            expect(page).to have_content (item.price * 3).to_s
            expect(page).to have_content "3"
            expect(page).to have_link "View"
          end
        end

        it "views the order total" do
          within(".total") do
            expect(page).to have_content (item.price * 3).to_s
          end
        end

        it "views the date and time order was placed" do
          within(".order") do
            expect(page).to have_content "Last Updated"
          end
        end

        it "views the current status" do
          within(".order") do
            expect(page).to have_content "Status"
            expect(page).to have_content status.name
          end
        end

        context "views item details" do
          before do
            item.update_attribute(:status, 1)
            click_link("View")
          end

          it "retired item does not have add to cart" do
            expect(current_path).to eq(meal_path(item))
            expect(page).to have_content(item.name)
            expect(page).not_to have_button("Add to Cart")
          end
        end
      end
    end
  end
end
