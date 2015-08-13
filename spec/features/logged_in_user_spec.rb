require "rails_helper"

RSpec.describe "the profile view", type: :feature do
  let!(:user) { Fabricate(:user) }

  context "a logged in user" do
    before do
      sign_in(user)
    end

    it "views profile info in navbar" do
      expect(current_path).to eq menu_path
      expect(page).to have_content "YeeHaw! #{user.username} is signed in!"
      expect(page).to have_link "Profile"

      within(".navbar-nav") do
        click_link "Profile"
      end

      expect(current_path).to eq profile_path
      expect(page).to have_content "#{user.username}'s Profile"
    end
  end

  context "user that's not logged in" do
    it "can't visit the profile page" do
      visit menu_path
      expect(page).to_not have_link "Profile"

      visit "/profile"
      expect(current_path).to eq "/404"
    end
  end

  context "a registered user that's not logged in" do
    it "can't visit the profile page" do
      visit menu_path
      expect(page).to_not have_link "Profile"

      visit "/profile"
      expect(current_path).to eq "/404"
    end
  end
end
