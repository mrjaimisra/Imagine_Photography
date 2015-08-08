require "rails_helper"

RSpec.describe "an admin" do
  it "can see all users on the dashboard" do
    admin = User.create(username: "Admin", password: "admin", role: 1)
    allow ApplicationController.to receive(:current_user).and_return(admin)

    register_user
    sign_in

    visit login_path
    within(".login-form") do
      fill_in "Username", with: admin.password
      fill_in "Password", with: "admin"
      click_button "Sign In"
    end

    expect(current_path).to eq(admin_path)
    expect(page).to have_content("Jason")
  end
end