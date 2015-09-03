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

  scenario "deletes photo" do
    visit explore_path

    expect(page).to have_xpath("//img[@src=\"#{photo.image.url(:medium)}\"]")

    visit root_path

    within(".navbar") do
      click_link "My Store"
    end

    find(:xpath, "//a/img[@src='#{photo.image.url(:medium)}']/..").click

    click_link("Edit photo")
    expect(current_path).to eq(edit_photo_path(photo))

    click_on("Delete photo")

    expect(current_path).to eq(explore_path)
    expect(page).to have_content("Photo successfully deleted")
    expect(page).to_not have_xpath("//img[@src=\"#{photo.image.url(:medium)}\"]")
  end
end
