require 'rails_helper'

RSpec.feature "a user can filter images by categories", type: :feature do

  let!(:category) { Category.create(name: "Landscape") }
  let!(:category2) { Category.create(name: "Wedding") }
  let!(:photographer) { Fabricate(:store) }
  let!(:photo) { Fabricate(:photo, store_id: photographer.id) }
  let!(:photo2) { Fabricate(:photo, category_id: category2.id) }

  scenario "on main explore page" do
    visit explore_path
    expect(page).to have_content(category.name)
    expect(page).to have_xpath("//img[@src=\"#{photo.image.url(:medium)}\"]")
    expect(page).to have_xpath("//img[@src=\"#{photo2.image.url(:medium)}\"]")

    click_on category.name
    expect(page).to have_xpath("//img[@src=\"#{photo.image.url(:medium)}\"]")
    expect(page).to_not have_xpath("//img[@src=\"#{photo2.image.url(:medium)}\"]")
  end

  scenario "on photographer page" do
    visit photographer_photos_path(photographer.url)
    expect(page).to have_content(photographer.name)
    expect(page).to have_content(category.name)
    expect(page).to have_xpath("//img[@src=\"#{photo.image.url(:medium)}\"]")
    expect(page).to have_xpath("//img[@src=\"#{photo2.image.url(:medium)}\"]")

    click_on category.name
    expect(page).to have_xpath("//img[@src=\"#{photo.image.url(:medium)}\"]")
    expect(page).to_not have_xpath("//img[@src=\"#{photo2.image.url(:medium)}\"]")
  end
end
