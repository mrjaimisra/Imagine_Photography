require 'rails_helper'

RSpec.feature "Guest deletes photo from cart", type: :feature do
  let!(:photo) { Fabricate(:photo) }
  let!(:second_photo) { Fabricate(:photo, description: "New description.") }

  before do
    visit photo_path(photo)
    click_on("Add to cart")
    visit photo_path(second_photo)
    click_on("Add to cart")
  end

  scenario "successfully" do
    expect(page).to have_content(photo.name)
    expect(page).to have_content(photo.description)
    expect(page).to have_content(second_photo.name)

    find('tr', text: photo.name).click_on("Remove")

    expect(current_path).to eq(cart_path)
    expect(page).to have_content(second_photo.name)
    expect(page).to_not have_content(photo.description)
  end
end
