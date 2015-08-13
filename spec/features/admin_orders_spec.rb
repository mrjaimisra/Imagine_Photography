require "rails_helper"

# And I can see the total number of orders for each status
# ("Ordered", "Paid", "Cancelled", "Completed")

RSpec.describe "an admin" do
  let!(:admin) { Fabricate(:user) }
  let!(:item) { Fabricate(:item) }

  let!(:ordered_status) { Status.create(name: "Ordered") }
  let!(:paid_status) { Status.create(name: "Paid") }
  let!(:cancelled_status) { Status.create(name: "Cancelled") }
  let!(:completed_status) { Status.create(name: "Completed") }

  let!(:order) { Order.create(user_id: admin.id, status_id: completed_status.id) }
  let!(:order_item) { OrderItem.create(order_id: order.id, quantity: 1, item_id: item.id) }

  context "visits admin dashboard" do
    before(:each) do
      sign_in(admin)
      admin.update_attribute("role", 1)
      visit admin_dashboard_path
      click_link "View All Orders"
    end

    it "can see all orders" do
      expect(page).to have_content("Ordered")
      expect(page).to have_content("Paid")
      expect(page).to have_content("Cancelled")
      expect(page).to have_content("Completed")

      expect(page).to have_content(order.id)
      expect(page).to have_content(order.total)
      expect(page).to have_content(order.status)
    end

    it "can click a link to view an order" do
      click_link "View"

      expect(current_path).to eq("/orders/#{order.id}")
      expect(page).to have_content("Order Number: #{order.id}")
    end

    it "can see ordered orders" do
      expect(page).to have_content(ordered_status.name)
      expect(page).to have_content(order.id)
      expect(page).to have_content(order.total)
      expect(page).to have_content(order.status)
    end

    it "can see paid orders" do
      expect(page).to have_content(paid_status.name)
      expect(page).to have_content(order.id)
      expect(page).to have_content(order.total)
      expect(page).to have_content(order.status)
    end

    it "can see cancelled orders" do
      expect(page).to have_content(cancelled_status.name)
      expect(page).to have_content(order.id)
      expect(page).to have_content(order.total)
      expect(page).to have_content(order.status)
    end

    it "can see completed orders" do
      expect(page).to have_content(completed_status.name)
      expect(page).to have_content(order.id)
      expect(page).to have_content(order.total)
      expect(page).to have_content(order.status)
    end

    it "can see the total number of orders for all types" do
      orders = Order.all

      expect(page).to have_content(orders.count)
    end

    it "can see the total number of ordered orders" do
      orders = Order.where(status_id: ordered_status.id)

      expect(page).to have_content(orders.count)
    end

    it "can see the total number of orders for paid orders" do
      orders = Order.where(status_id: paid_status.id)

      expect(page).to have_content(orders.count)
    end

    it "can see the total number of orders for cancelled orders" do
      orders = Order.where(status_id: cancelled_status.id)

      expect(page).to have_content(orders.count)
    end

    it "can see the total number of orders for completed orders" do
      orders = Order.where(status_id: completed_status.id)

      expect(page).to have_content(orders.count)
    end
  end
end