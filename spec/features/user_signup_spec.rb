require "rails_helper"

RSpec.describe "a user who signs up", type: :feature do

  context "stays on the sign up page" do

    it "when they dont enter a username" do
      visit sign_up_path

      expect(current_path).to eq(sign_up_path)

      within(".create-user-form") do
        fill_in "Password", with: "secret"
        click_button "Sign Up"
      end

      expect(current_path).to eq(sign_up_path)
      expect(page).to have_content("Ya screwed something up parter, try again!")
    end

    it "when they dont enter a password" do
      visit sign_up_path

      expect(current_path).to eq(sign_up_path)

      within(".create-user-form") do
        fill_in "Username", with: "Ruffus"
        click_button "Sign Up"
      end

      expect(current_path).to eq(sign_up_path)
      expect(page).to have_content("Ya screwed something up parter, try again!")
    end
  end
end
