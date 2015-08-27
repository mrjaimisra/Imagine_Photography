require 'rails_helper'

RSpec.feature "User visits explore page", type: :feature do
  let!(:photo) { Fabricate(:photo) }
  let!(:second_photo) { Fabricate(:photo) }

  scenario "successfully" do
    visit explore_path

    within("h1") do
      expect(page).to have_content("Explore")
    end

    expect(page).to have_content(photo.name)
    expect(page).to have_content(second_photo.name)
  end
end
