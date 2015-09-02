# As a signed in customer, when I click "Profile",
# I should be redirected to my profile page, where I can see:
# All of the photos I purchased previously
# A link to edit my account information (username and password)

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
      click_link "Profile"
    end

    expect(current_path).to eq(profile_path)
    expect(page).to have_link("Edit")
    expect(page).to have_xpath("//img[@src=\"#{photo.image.url(:medium)}\"]")
  end
end
