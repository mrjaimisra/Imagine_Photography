# As a signed in customer, when I click "Profile",
# I should be redirected to my profile page, where I can see:
# All of the photos I purchased previously
# A link to edit my account information (username and password)
# A link to see all of my previous orders

require 'rails_helper'

RSpec.feature "Customer visits profile", type: :feature do
  before do
    build_roles
  end
  let!(:customer) { Fabricate(:user) }
  let!(:photo) { Fabricate(:photo) }
  let!(:order) { Order.create(user_id: customer.id) }


  scenario "successfully" do
    order.photos << photo

    visit root_path
    sign_in_customer
    expect(current_path).to eq(explore_path)

    within(".navbar") do
      click_link "You"
    end

    expect(current_path).to eq(explore_path)
    # expect(page).to have_link("Edit")
    # within(".orders") do
    #   expect(page).to have_content(order.id)
    # end
  end

  private

  def sign_in_customer
    within(".navbar") do
      click_link "Sign in"
    end

    fill_in "Email", with: customer.email
    fill_in "Password", with: customer.password
    click_button "Sign in"
  end
end

