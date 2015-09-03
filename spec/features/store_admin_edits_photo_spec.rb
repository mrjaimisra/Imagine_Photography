require 'rails_helper'

RSpec.feature "Store admin", type: "feature" do
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

  let!(:photo) { Fabricate(:photo, store_id: @store.id) }

  scenario "edits photo" do
    visit root_path

    within(".navbar") do
      click_link "My Store"
    end

    expect(page).to have_content(@store.name)
    expect(page).to have_content(@store.email)
    expect(page).to have_xpath("//img[@src=\"#{photo.image.url(:medium)}\"]")

    find(:xpath, "//a/img[@src='#{photo.image.url(:medium)}']/..").click

    expect(current_path).to eq(photo_path(photo))
    expect(page).to have_link("Edit photo")

    click_link("Edit photo")
    expect(current_path).to eq(edit_photo_path(photo))

    fill_in "Title", with: "New Title"
    fill_in "Description", with: "Description"
    fill_in "Price", with: 50
    click_button "Submit"

    photo.reload

    expect(current_path).to eq(photo_path(photo))
    expect(photo.name).to eq("New Title")
    expect(photo.description).to eq("Description")
    expect(photo.price).to eq(50)
  end

  scenario "cannot edit photo without necessary information" do
    visit root_path

    within(".navbar") do
      click_link "My Store"
    end

    find(:xpath, "//a/img[@src='#{photo.image.url(:medium)}']/..").click

    click_link("Edit photo")

    fill_in "Title", with: ""
    fill_in "Description", with: "Description"
    fill_in "Price", with: 50
    click_button "Submit"

    expect(current_path).to eq(edit_photo_path(photo))
    expect(page).to have_content("Update failed, please enter valid information in all fields")
  end
end
