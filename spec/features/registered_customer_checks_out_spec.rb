require 'rails_helper'

RSpec.feature "Customer checks out", type: :feature do
  before do
    build_roles
  end
  let!(:customer) { Fabricate(:user) }
  let!(:photo)    { Fabricate(:photo) }
  let!(:status)   { Status.create(name: "ordered") }

  scenario "successfully" do
    visit root_path
    click_link "Sign in"

    fill_in "Email", with: customer.email
    fill_in "Password", with: customer.password
    click_button "Sign in"

    expect(current_path).to eq(explore_path)

    find(:xpath, "//a/img[@src='#{photo.image.url(:medium)}']/..").click
    click_button "Add to cart"

    expect(current_path).to eq(cart_path)
    expect(page).to have_content(photo.name)

    click_on "Checkout"
    expect(current_path).to eq(order_path(Order.last))
    expect(Order.last.status.name).to eq("Ordered")
  end
end
