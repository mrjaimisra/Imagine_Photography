require "rails_helper"

RSpec.feature "user visits home page" do
  scenario "successfully" do
    visit "/"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Sign in")
    expect(page).to have_content("Explore")
    expect(page).to have_content("Photographers")
    expect(page).to have_xpath("//a[@href=\"#{cart_path}\"]")
  end
end
