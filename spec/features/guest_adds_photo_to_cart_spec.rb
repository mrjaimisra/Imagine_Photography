require 'rails_helper'

RSpec.feature "Guest adds photo to cart", type: :feature do
  let!(:photo) { Fabricate(:photo) }
  let!(:second_photo) { Fabricate(:photo) }

  scenario "successfully" do
    visit photo_path(photo)
    click_on("Add to cart")
    expect(current_path).to eq cart_path
    click_on("Keep shopping")

    expect(current_path).to eq(explore_path)

    visit photo_path(second_photo)
    click_on("Add to cart")

    expect(current_path).to eq(cart_path)
    expect(page).to have_content(photo.name)
    expect(page).to have_content(second_photo.name)
  end
end
