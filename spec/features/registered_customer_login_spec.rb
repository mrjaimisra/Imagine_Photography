require 'rails_helper'

RSpec.feature "Registered customer logs in", type: :feature do
  before do
    build_roles
  end
  let!(:user) { Fabricate(:user) }

  scenario "successfully" do
    visit root_path
    click_link "Sign in"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"

    expect(current_path).to eq(explore_path)

    within(".navbar") do
      expect(page).to have_link("Profile")
      expect(page).to have_link("Settings")
      expect(page).to have_link("Sign out")
      expect(page).to_not have_link("Sign in")
    end
  end
end
