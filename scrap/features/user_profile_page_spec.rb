require "rails_helper"

RSpec.describe "the user profile page", type: :feature do
  context "a logged in user" do
    let!(:user) { Fabricate(:user) }

    before do
      sign_in(user)
      click_link "Profile"
    end

    it "has a title" do
      expect(page).to have_content "#{user.username}'s Profile"
    end

    it "has a header" do
      expect(page).to have_content "Account Information"
    end

    it "has titles" do
      within(".profile") do
        expect(page).to have_content "Name"
        expect(page).to have_content "Address"
        expect(page).to have_content "Phone Number"
      end
    end

    it "displays account information" do
      within(".user-info") do
        expect(page).to have_content "#{user.username}"
        expect(page).to have_content "#{user.street_name}, #{user.zipcode}"
        expect(page).to have_content "#{user.phone_number}"
        expect(page).to have_link "Edit Profile"
      end
    end

    context "a logged in user can edit account information" do
      it "can edit information" do
        click_link "Edit Profile"
        expect(current_path).to eq profile_edit_path

        fill_in "Username", with: "Mia"
        fill_in "Password", with: "password"
        click_button "Update Info"

        expect(current_path).to eq profile_path(user)
        within(".user-info") do
          expect(page).to have_content "Mia"
        end
      end
    end
  end
end
