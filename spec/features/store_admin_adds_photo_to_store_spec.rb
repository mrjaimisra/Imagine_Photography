require "rails_helper"

RSpec.feature "A store admin" do
  attr_reader :store, :store_admin, :photo, :other_store

  before do
    build_roles
    build_categories
    @store = Fabricate(:store)
    @other_store = Store.create(name: "BLAH", email: "BLAH@example.com")
    @store_admin = Fabricate(:user, store_id: store.id)
    @photo = Fabricate(:photo, store_id: store.id, image_url: "beach_van.jpg")
    store_admin.roles << Role.find_by(name: "store_admin")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(store_admin)
  end

  scenario "adds business photo" do
    expect(store_admin).to be_store_admin
    visit photographer_photos_path(photographer: store.url)

    click_on "Upload photo to portfolio"

    expect(current_path).to eq(new_photographer_photo_path(photographer: store.url))

    attach_file "Image",   "spec/fixtures/images/beach_van.jpg"
    fill_in "Title",       with: "My Photo"
    fill_in "Description", with: "A bitchin photo"
    fill_in "Price",       with: "150.00"
    find('select#photo_category_id').find("option[value='2']").select_option
    click_on "Submit"

    expect(current_path).to eq(photographer_photos_path(photographer: store.url))
    expect(page).to have_content(store.name)
    expect(page).to have_content(store.email)
    expect(page).to have_xpath("//img[@src=\"#{photo.image.url(:medium)}\"]")
  end

  scenario "cannot add photos to different store" do

    visit new_photographer_photo_path(other_store.url)
    expect(current_path).to eq(root_path)
  end
end
