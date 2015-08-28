require 'rails_helper'

RSpec.feature "Guest creates account", type: :feature do
  before do
    build_roles
    visit login_path
    click_link "Sign up"
  end

  scenario "successfully" do
    expect(current_path).to eq(sign_up_path)

    fill_in "Name", with: "Jai"
    fill_in "Email", with: "jai@awesomesauce.net"
    fill_in "Password", with: "password"

    click_button "Create account"

    expect(current_path).to eq(explore_path)
    expect(page).to have_content("Account successfully created!")
  end

  scenario "unsuccessfully due to name being blank" do
    fill_in "Name", with: ""
    fill_in "Email", with: "jai@awesomesauce.net"
    fill_in "Password", with: "password"

    click_button "Create account"

    expect(current_path).to eq(sign_up_path)
    expect(page).to have_content("Name can't be blank")
  end

  scenario "unsuccessfully due to name being too long" do
    fill_in "Name", with: "J" * 51
    fill_in "Email", with: "jai@awesomesauce.net"
    fill_in "Password", with: "password"

    click_button "Create account"

    expect(current_path).to eq(sign_up_path)
    expect(page).to have_content("Name is too long (maximum is 50 characters)")
  end

  scenario "unsuccessfully due to email being blank" do
    fill_in "Name", with: "J"
    fill_in "Email", with: ""
    fill_in "Password", with: "password"

    click_button "Create account"

    expect(current_path).to eq(sign_up_path)
    expect(page).to have_content("Email can't be blank")
  end

  scenario "unsuccessfully due to email already being taken" do
    User.create(name: "Joe", email: "joe@joe.jo", password: "pw")

    fill_in "Name", with: "J"
    fill_in "Email", with: "joe@joe.jo"
    fill_in "Password", with: "password"

    click_button "Create account"

    expect(current_path).to eq(sign_up_path)
    expect(page).to have_content("Email has already been taken")
  end

  scenario "unsuccessfully due to email being too long" do
    fill_in "Name", with: "J"
    fill_in "Email", with: "j" * 256
    fill_in "Password", with: "password"

    click_button "Create account"

    expect(current_path).to eq(sign_up_path)
    expect(page).to have_content("Email is too long (maximum is 255 characters)")
  end

  scenario "unsuccessfully due to email being invalid" do
    fill_in "Name", with: "J"
    fill_in "Email", with: "joe@joe_joe.jo"
    fill_in "Password", with: "password"

    click_button "Create account"

    expect(current_path).to eq(sign_up_path)
    expect(page).to have_content("Email is invalid")
  end

  scenario "unsuccessfully due to password being blank" do
    fill_in "Name", with: "J"
    fill_in "Email", with: "joe@joe.jo"
    fill_in "Password", with: ""

    click_button "Create account"

    expect(current_path).to eq(sign_up_path)
    expect(page).to have_content("Password can't be blank")
  end

  scenario "unsuccessfully due to password being too long" do
    fill_in "Name", with: "J"
    fill_in "Email", with: "joe@joe.jo"
    fill_in "Password", with: "p" * 51

    click_button "Create account"

    expect(current_path).to eq(sign_up_path)
    expect(page).to have_content("Password is too long (maximum is 50 characters)")
  end

end
