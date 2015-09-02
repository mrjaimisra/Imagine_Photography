# As a business admin,
# when I visit my business homepage and click "Upload photo to portfolio"
# I expect to be directed to a page where I can upload a photo and give it a name,
# description, and price. After filling in the information and clicking on "Upload"
# I expect to be taken to the new item show page.

require 'rails_helper'

RSpec.feature "Store admin", type: "feature" do
  before do
    build_roles
  end

  let!(:role) { Role.create(name: "store_admin") }
  let!(:photographer) { Fabricate(:store) }
  let!(:store_admin) { Fabricate(:user, store_id: photographer.id) }
  let!(:user_role) { UserRole.create(user_id: photographer.id, role_id: role.id)}
  let!(:photo) { Fabricate(:photo, store_id: photographer.id) }

  xscenario "edits photo" do
    visit root_path
    sign_in_store_admin

    within(".navbar") do
      click_link "My Store"
    end

    expect(page).to have_content(photographer.name)
    expect(page).to have_content(photographer.email)

    expect(page).to have_xpath("//img[@src=\"#{photo.image.url(:medium)}\"]")
    expect(page).to have_link("Add photo")

    click_link("Add photo")
    expect(current_path).to eq(new_photo_path)

    fill_in "Title", with: "New Title"
    find('select#photo_category_id').find("option[value='2']").select_option
    fill_in "Description", with: "Description"
    fill_in "Price", with: "Price"
    click_button "Submit"
  end
end