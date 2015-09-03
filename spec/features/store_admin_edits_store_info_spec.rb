require "rails_helper"

RSpec.feature "Store admin" do
  before do
    build_roles
    Store.create( name: "Linda Synder", email: "linda@snyder.com")
    Store.create( name: "Danielle Austin", email: "danielle@austin.com")
    Store.create( name: "Anne Johnson", email: "anne@johnson.com")

    @store       = Fabricate(:store)
    @store_admin = Fabricate(:user)
    @store_admin.update_attributes(store_id: @store.id)
    @store_admin.roles << Role.find_by(name: "store_admin")

    allow_any_instance_of(ApplicationController).to receive(
      :current_user).and_return(@store_admin)

  end

  scenario "can edit the store information" do
    visit root_path

    click_link "Edit Store"

    expect(page).to have_content "Edit Store"

    fill_in "Store Name", with: "Sandra Smith Photography"
    fill_in "Email",      with: "sandra@example.com"

    click_button "Update Store"
    @store.reload

    expect(current_path).to eq photographer_photos_path(photographer: @store.url)
    expect(page).to have_content "Sandra Smith"
    expect(page).to have_content 'sandra@example.com'
  end

  scenario "can edit the store information" do
    visit root_path

    click_link "Edit Store"

    expect(page).to have_content "Edit Store"

    fill_in "Store Name", with: ""
    fill_in "Email",      with: "sandra@example.com"

    click_button "Update Store"
    expect(current_path).to eq photographer_path(photographer: @store.url)
    expect(page).to have_content "Name can't be blank"
  end

  scenario "can edit the store information" do
    visit root_path

    click_link "Edit Store"

    expect(page).to have_content "Edit Store"

    fill_in "Store Name", with: "Sandra Smith"
    fill_in "Email",      with: ""

    click_button "Update Store"
    expect(current_path).to eq photographer_path(photographer: @store.url)
    expect(page).to have_content "Email can't be blank"
  end
end
