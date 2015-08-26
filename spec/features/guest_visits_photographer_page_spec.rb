require 'rails_helper'

RSpec.feature "GuestVisitsPhotographerPage", type: :feature do
  let!(:photographer) { Fabricate(:store) }

  scenario "successfully" do
    visit root_path
    click_link "Photographers"
    click_link "#{photographer.name}"

    expect(current_path).to eq(photographer_photos_path(photographer.url))
  end
end
