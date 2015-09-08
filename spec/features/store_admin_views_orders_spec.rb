require 'rails_helper'

# acceptance test
RSpec.feature "Store admin", type: "feature" do
  before do
    build_roles
    Store.create( name: "Linda Synder", email: "linda@snyder.com")
    Store.create( name: "Danielle Austin", email: "danielle@austin.com")
    Store.create( name: "Anne Johnson", email: "anne@johnson.com")

    @customer    = Fabricate(:user)
    @store       = Fabricate(:store)
    @store_admin = Fabricate(:user, email: "admin@mystore.com")
    @store_admin.update_attributes(store_id: @store.id)
    @store_admin.roles << Role.find_by(name: "store_admin")

    # allow_any_instance_of(ApplicationController).to receive(
    #                               :current_user).and_return(@store_admin)
  end

  let!(:photo) { Fabricate(:photo, store_id: @store.id) }

  scenario "can view orders created by a user" do
    visit login_path
    fill_in "Email", with: @customer.email
    fill_in "Password", with: @customer.password
    click_button "Sign in"

    expect(page).to have_content("#{@customer.name} is signed in!")

    within(".thumbnail") do
      find("a").click
    end

    expect(page).to have_content(photo.name)
    expect(page).to have_content(photo.description)

    click_on "Add to cart"

    expect(page).to have_content("Shopping Cart")
    expect(page).to have_content(photo.name)
    expect(page).to have_content(photo.description)

    click_on "Checkout"

    expect(page).to have_content "Order #"
    expect(page).to have_content(photo.name)

    click_on "Sign out"
    click_on "Sign in"

    fill_in "Email", with: @store_admin.email
    fill_in "Password", with: @store_admin.password
    click_button "Sign in"

    expect(page).to have_content("#{@store_admin.name} is signed in!")

    within("#store-nav") do
      click_on "Orders"
    end

    expect(page).to have_content "#{@store.name} Orders"
    expect(page).to have_content "Order #"
    expect(page).to have_content "Order Updated"
    expect(page).to have_content "Customer"
    expect(page).to have_link    "1"
    expect(page).to have_content @customer.email
    expect(page).to have_content photo.price
    expect(page).to have_content "View"

    click_on "View"

    expect(page).to have_content "Order #1"
    expect(page).to have_content "Status: Ordered"
    expect(page).to have_content photo.name
    expect(page).to have_content photo.price
    expect(page).to have_content "Total: $#{photo.price}"
  end

end
