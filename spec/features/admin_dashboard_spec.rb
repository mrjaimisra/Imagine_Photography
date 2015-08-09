require "rails_helper"

RSpec.describe "an admin" do
  context "an admin" do
    it "can visit the admin dashboard" do
      register_user
      admin = User.create(username: "Admin", password: "admin", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user)
        .and_return(admin)

      click_link "Sign In"
      within(".login-form") do
        fill_in "Username", with: admin.username
        fill_in "Password", with: "admin"
        click_button "Sign In"
      end

      expect(current_path).to eq menu_path
      visit "/admin/users"

      expect(page).to eq admin_dashboard_index_path

      within(".nav-header") do
        expect(page).to have_content "Admin Dashboard"
      end
    end
  end

  context "a registered user" do
    it "can not access the admin dashboard" do
      register_user
      sign_in

      visit "/admin/dashboard"
      expect(current_path).to eq "/404"
    end
  end

  context "an unregistered user" do
    it "can not access the admin dashboard" do
      visit "/admin/dashboard"
      expect(current_path).to eq "/404"
    end
  end
end
