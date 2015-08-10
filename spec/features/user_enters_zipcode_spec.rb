require "rails_helper"

RSpec.describe "the zipcode filter", type: :feature do
  context "a user enters a zipcode" do
    it "can get delivery within allowed radius" do
      visit menu_path

      within(".text-box") do
        fill_in "Zipcode", with: "80303"
        click_button "Submit"
      end

      expect(page).to have_content "We deliver in your area!"
    end

    it "can not deliver within unallowed radius" do
      visit menu_path

      within(".text-box") do
        fill_in "Zipcode", with: "99501"
        click_button "Submit"
      end

      expect(page).to have_content "We unfortunately do not deliver in your area."
    end
  end
end
