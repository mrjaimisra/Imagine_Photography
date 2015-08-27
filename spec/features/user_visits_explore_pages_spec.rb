require 'rails_helper'

RSpec.feature "User visits explore page", type: :feature do
  before do
    visit photos_path
  end

  xscenario "successfully" do
    within("h1") do
      expect(page).to have_content("Explore")
    end
    expect(page).to have_content("Landscape")
    expect(current_path).to eq('/explore')
    expect(page).to have_xpath("//a[@href=\"/photos/2\"]")
    expect(page).to have_selector(".thumbnail", count: 10)
  end
end
