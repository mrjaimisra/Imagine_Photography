require 'rails_helper'

RSpec.feature "Guest visits explore page", type: :feature do
  let!(:photographer) { Fabricate(:store) }
  let(:photo)        { Fabricate(:photo) }
  let(:second_photo) { Fabricate(:photo) }

  before do
    build_categories
    photo.update_attribute(:store_id, photographer.id)
    photo.update_attribute(:category_id, Category.first.id)
    second_photo.update_attribute(:store_id, photographer.id)
    second_photo.update_attribute(:category_id, Category.first.id)
  end

  scenario "successfully" do
    visit explore_path

    within("h1") do
      expect(page).to have_content("Explore")
    end
    expect(page).to have_xpath("//img[@src=\"#{photo.image.url}\"]")
  end

  scenario "and does not see error message" do
    visit explore_path

    expect(page).not_to have_content "You're not authorized to visit this page!"
  end
end
