require "rails_helper"

RSpec.feature "User visits home page" do
  before do
    visit root_path
  end

  scenario "successfully" do
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Sign in")
    expect(page).to have_content("Explore")
    expect(page).to have_content("Photographers")
    expect(page).to have_xpath("//a[@href=\"#{cart_path}\"]")
    expect(page).to have_xpath("//a[@href=\"#{photographers_path}\"]")
  end

  xscenario "and clicks photographers" do
    click_link("Photographers")

    expect(current_path).to eq(photographers_path)

    within("h1") do
      expect(page).to have_content("Photographers")
    end
  end
end
