require "rails_helper"

RSpec.describe "an admin" do
  let!(:admin) { Fabricate(:user) }

  context "an admin" do
    it "can visit the admin dashboard" do
      sign_in(admin)
      admin.role = 1

      allow_any_instance_of(ApplicationController).to receive(:current_user)
        .and_return(admin)

      expect(current_path).to eq menu_path
      visit "/admin/dashboard"

      expect(current_path).to eq admin_dashboard_path

      within(".nav-header") do
        expect(page).to have_content "Admin Dashboard"
      end
    end
  end

  context "a registered user" do
    it "can not access the admin dashboard" do
      sign_in(admin)
      admin.role = 1

      visit "/admin/dashboard"
      expect(page).to have_content "The page you were looking for doesn't exist."
    end
  end

  context "an unregistered user" do
    it "can not access the admin dashboard" do
      visit "/admin/dashboard"
      expect(page).to have_content "The page you were looking for doesn't exist."
    end
  end
end
