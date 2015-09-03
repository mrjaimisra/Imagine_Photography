require 'rails_helper'

RSpec.feature "GuestVisitsPhotographersPages", type: :feature do
  let!(:photographer) { Fabricate(:store) }

  before do
    Store.create( name: "Linda Synder", email: "linda@snyder.com")
    Store.create( name: "Danielle Austin", email: "danielle@austin.com")
    Store.create( name: "Anne Johnson", email: "anne@johnson.com")
  end

  scenario "successfully" do
    visit root_path

    click_link "Photographers"
    expect(current_path).to eq(photographers_path)

    within("h1") do
      expect(page).to have_content("Photographers")
    end
  end

  scenario "can see all photographers" do
    visit photographers_path

    expect(page).to have_content(photographer.name)
  end
end
