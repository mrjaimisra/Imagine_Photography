require 'rails_helper'

RSpec.feature "Guest attempts login", type: :feature do
  let!(:role) { Role.create }

  let!(:user) {
    Fabricate(:user)
  }

  before do
    user.roles << role
  end

  scenario "without login credentials" do
    visit login_path
    click_button "Sign in"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Invalid login information!")
  end

  scenario "without valid email" do
    visit login_path

    fill_in "Email", with: "blah"
    fill_in "Password", with: user.password

    click_button "Sign in"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Invalid login information!")
  end

  scenario "without valid password" do
    visit login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: "blah"

    click_button "Sign in"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Invalid login information!")
  end
end
