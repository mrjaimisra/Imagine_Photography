require 'rails_helper'

RSpec.feature "Guest visits explore page", type: :feature do
  let!(:category)     { Category.create(name: "People") }
  let!(:photographer) { Fabricate(:store) }
  let!(:photo)        { photographer.photos.create(
                          name: "My Photo",
                          description: "My description",
                          price:       "120.00",
                          category_id: category.id,
                          status: 1,
                          image: File.open("spec/fixtures/images/beach_van.jpg")
                       ) }

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
