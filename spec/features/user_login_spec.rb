require "rails_helper"

RSpec.describe "a user", type: :feature do
  context "who is unregistered" do
    it "is logged in when they create an account" do
      visit root_path
      click_link "Sign In"
      expect(current_path).to eq(login_path)
      click_link "Sign Up"
      expect(current_path).to eq(sign_up_path)

      within(".create-user-form") do
        fill_in "Username", with: "Lovisa"
        fill_in "Password", with: "Sweden"
        click_button "Sign Up"
      end

      expect(current_path).to eq(menu_path)
      within(".navbar-nav") do
        expect(page).to have_content("Sign Out")
        expect(page).to_not have_content("Sign In")
        expect(page).to have_content("Lovisa")
      end
    end

    it "cannot login without an account" do
      visit root_path
      click_link "Sign In"

      within(".login-form") do
        fill_in "Username", with: "Jason"
        fill_in "Password", with: "Noob"
        click_button "Sign In"
      end

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Sorry m'friend. You go HUNGRY!")
    end

    it "can log out" do
      visit login_path
      click_link "Sign Up"

      within(".create-user-form") do
        fill_in "Username", with: "Jason"
        fill_in "Password", with: "Noob"
        click_button "Sign Up"
      end

      visit root_path
      within(".navbar-nav") do
        click_link("Sign Out")
      end

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Sign In")
    end
  end

  context "a registered user" do
    it "can log in" do
      register_user
      visit menu_path
      click_link "Sign In"

      fill_in "Username", with: "Jason"
      fill_in "Password", with: "Noob"
      click_button "Sign In"

      within(".navbar-nav") do
        expect(page).to have_content("Jason")
        expect(page).to have_content("Sign Out")
      end
    end
  end

  def register_user
    visit login_path
    click_link "Sign Up"

    within(".create-user-form") do
      fill_in "Username", with: "Jason"
      fill_in "Password", with: "Noob"
      click_button("Sign Up")
    end
    click_link "Sign Out"
    expect(page).to have_content("Sign In")
  end
end

