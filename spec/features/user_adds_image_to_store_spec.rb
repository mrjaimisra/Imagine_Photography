require "rails_helper"

RSpec.feature "A store admin" do
  let(:user)  { Fabricate(:user) }
  let(:store) { Fabricate(:store) }
  let(:photo) { Fabricate(:photo) }

  before do
    build_roles
    build_categories
    user.roles << Role.find_by(name: "store_admin")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  scenario "adds business photo" do
    expect(user).to be_store_admin
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
    within(".thumbnail") do
      expect(page).to have_selector("img")
    end
    
  end
end
