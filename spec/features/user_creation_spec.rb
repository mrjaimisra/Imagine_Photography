require "rails_helper"

RSpec.describe "can create a new user", type: :feature do
  context "a new user" do
    it "can be created" do
      visit root_path
      click_link "Login"
      expect(current_path).to eq(login_path)

      within(".login-form") do
        fill_in "Username", with: "Lovisa"
        fill_in "Password", with: "Sweden"
        click_button "Sign Up"
      end

      expect(current_path).to eq(menu_path)
      within(".nav .navbar-nav") do
        expect(page).to have_content("Logout")
        expect(page).to_not have_content("Login")
        expect(page).to have_content("Lovisa")
      end
    end
  end
end