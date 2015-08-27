require 'rails_helper'

RSpec.feature "GuestVisitsPhotographerPage", type: :feature do
  let!(:photographer) { Fabricate(:store) }
  let!(:photo) { Fabricate(:photo) }

  before do
    photo.update_attribute(:store_id, photographer.id)
  end

  scenario "successfully" do
    visit root_path
    click_link "Photographers"
    click_link photographer.name

    expect(current_path).to eq(photographer_photos_path(photographer.url))
  end

  scenario "and visits individual photo page" do
    visit photographer_photos_path(photographer.url)
    click_link photo.name
    expect(current_path).to eq(photo_path(photo))
  end
end
