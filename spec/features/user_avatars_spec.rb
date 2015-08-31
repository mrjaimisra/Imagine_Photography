require 'rails_helper'

RSpec.feature "User", type: :feature do
  let(:user) { Fabricate.build(:user) }

  before do
    build_roles
  end

  scenario 'creates account with avatar' do
    visit sign_up_path

    fill_in "Name", with: user.name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    attach_file "Avatar", "spec/fixtures/images/headshot.jpg"
    attach_file "Header", "spec/fixtures/images/beach_van.jpg"

    click_button "Create account"

    expect(current_path).to eq(explore_path)
    expect(page).to have_content("Account successfully created!")

    click_on "You"

    expect(current_path).to eq(profile_path(user))

    expect(page).to have_content user.name
    expect(page).to have_content user.email
    expect(page).to have_content user.avatar.url
    expect(page).to have_content user.header.url
  end


end
