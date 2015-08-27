require 'rails_helper'

RSpec.feature "Guest creates account", type: :feature do
  before do
    build_roles
  end

  scenario "successfully" do
    visit login_path
    click_link "Sign up"

    expect(current_path).to eq(sign_up_path)

    fill_in "Name", with: "Jai"
    fill_in "Email", with: "jai@awesomesauce.net"
    fill_in "Password", with: "password"

    click_button "Create account"

    expect(current_path).to eq(explore_path)
    expect(page).to have_content("Account successfully created!")
  end
end
