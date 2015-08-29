require 'rails_helper'

RSpec.feature "Registered customer views orders", type: :feature do
  before do
    build_roles
  end
  let!(:user) { Fabricate(:user) }

  scenario "successfully" do
    order = Order.create(user_id: user.id)
    user.orders << order

    visit root_path
    click_link "Sign in"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"

    expect(current_path).to eq(explore_path)

    click_on "Orders"

    expect(current_path).to eq(orders_path)
    expect(page).to have_content("#{user.name}'s Orders")
    expect(page).to have_content(order.id)
  end
end
