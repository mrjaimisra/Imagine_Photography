require "rails_helper"

RSpec.describe "a user", type: :feature do
  context "who is unregistered" do
    let(:user) { Fabricate(:user) }

    it "is logged in when they create an account" do
      visit root_path

      click_link "Sign In"
      expect(current_path).to eq login_path

      click_link "Sign Up"
      expect(current_path).to eq sign_up_path

      sign_in(user)

      expect(current_path).to eq menu_path

      within(".navbar-nav") do
        expect(page).to have_content "Sign Out"
        expect(page).to_not have_content "Sign In"
      end
    end

    it "cannot login without an account" do
      visit root_path
      click_link "Sign In"

      within(".login-form") do
        fill_in "Username", with: "Wrong name"
        fill_in "Password", with: "No password"
        click_button "Sign In"
      end

      expect(current_path).to eq(login_path)
      expect(page).to have_content "Sorry m'friend. You go HUNGRY!"
    end
  end

  context "a registered user" do
    let!(:user) { Fabricate(:user) }

    it "can log in" do
      sign_in(user)

      within(".navbar-nav") do
        expect(page).to have_content "Sign Out"
        expect(page).to have_link "Profile"
      end
    end

    it "can sign out and sign in" do
      sign_in(user)

      click_link "Sign Out"
      click_link "Sign In"
      expect(page).to_not have_content "YeeHaw! Jason is signed in!"

      sign_in(user)

      expect(page).to have_content "YeeHaw! Jason is signed in!"
      expect(page).to have_content "Sign Out"
    end

    it "can log out" do
      sign_in(user)

      visit root_path
      within(".navbar-nav") do
        click_link("Sign Out")
      end

      expect(current_path).to eq root_path
      expect(page).to have_content "Sign In"
    end
  end

  context "an admin" do
    let!(:user) { Fabricate(:user, role: 1) }

    it "is an admin" do
      expect(user.admin?).to eq true
    end

    it "has a link to admin dashboard in show page" do
      sign_in(user)
      expect(current_path).to eq menu_path
      expect(page).to have_content "Dashboard"
      expect(page).to_not have_content "Profile"
    end
  end
end
