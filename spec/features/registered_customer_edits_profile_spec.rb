require 'rails_helper'

RSpec.feature "Customer edits profile", type: "feature" do
  before do
    build_roles
  end
  let!(:customer) { Fabricate(:user) }

  scenario "successfully" do
    old_name      = customer.name
    old_email     = customer.email
    old_password  = customer.password

    sign_in_customer

    within(".navbar") do
      click_link("Profile")
    end

    expect(page).to have_content(old_name)
    expect(page).to have_content(old_email)

    click_link "Edit"

    expect(current_path).to eq(profile_edit_path)

    new_name = "Joshua"
    new_email = "Joshua@turing.io"
    new_password = "password2"

    fill_in "Name", with: new_name
    fill_in "Email", with: new_email
    fill_in "Password", with: new_password
    click_button "Update profile"

    customer.reload

    expect(current_path).to eq(profile_path)
    expect(page).to have_content(new_name)
    expect(page).to have_content(new_email)

    within(".navbar") do
      click_link "Sign out"
    end

    expect(current_path).to eq(root_path)

    within(".navbar") do
      click_link "Sign in"
    end

    fill_in "Email", with: old_email
    fill_in "Password", with: old_password
    click_button "Sign in"

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Invalid login information!")

    fill_in "Email", with: new_email
    fill_in "Password", with: new_password
    click_button "Sign in"

    expect(current_path).to eq(explore_path)
    expect(page).to have_content("#{new_name} is signed in!")
  end
end
