require "rails_helper"

RSpec.describe "a user with past orders", type: :feature do
  let!(:item) { Fabricate(:item) }
  let!(:user) { Fabricate(:user) }
  let!(:status) { Status.create(name: "pending") }
  let!(:order) { Order.create(user_id: user.id, status_id: status.id) }

  before do
    allow_any_instance_of(OrdersController)
      .to receive(:send_text_message).and_return(true)
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
          expect(page).to have_content("Order Updated Date")
          expect(page).to have_link(item.id)
          expect(page).to have_link(item.id)
          expect(page).to have_content((item.price * 3).to_s)
          expect(page).to have_content(item.price)
        end
      end

      it "can see the date the order status changed" do
        todays_date = Order.create(user_id: user.id, status_id: status.id)
                        .updated_at
                        .strftime("%A, %b %d %Y %l:%M %p")

        order.update_attribute("status_id", 2)

        within(".orders") do
          expect(page).to have_content(todays_date)
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
