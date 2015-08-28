require 'rails_helper'

RSpec.feature "Registered customer logs in", type: :feature do
  before do
    build_roles
  end
  let!(:user) { Fabricate(:user) }

  scenario "successfully" do
    sign_in_registered_customer
    expect(current_path).to eq(explore_path)
  end

  scenario "and can see a link to Profile" do
    sign_in_registered_customer
    within(".navbar") do
      expect(page).to have_link("Profile")
    end
  end

  scenario "and can see a link to Settings" do
    sign_in_registered_customer
    within(".navbar") do
      expect(page).to have_link("Settings")
    end
  end

  scenario "and can see a link to Sign out" do
    sign_in_registered_customer
    within(".navbar") do
      expect(page).to have_link("Sign out")
    end
  end

  scenario "and cannot see a link to Sign in" do
    sign_in_registered_customer
    within(".navbar") do
      expect(page).to_not have_link("Sign in")
    end
  end

  private

    def sign_in_registered_customer
      visit root_path
      click_link "Sign in"

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
    end
end
