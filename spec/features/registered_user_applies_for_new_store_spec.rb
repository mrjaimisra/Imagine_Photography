require "rails_helper"

RSpec.feature "Registered user" do
  before do
    build_roles
    Store.create( name: "Linda Synder", email: "linda@snyder.com")
    Store.create( name: "Danielle Austin", email: "danielle@austin.com")
    Store.create( name: "Anne Johnson", email: "anne@johnson.com")
  end

  scenario "visits the new store page and submits an application" do
    customer = Fabricate(:user)

    visit login_path
    fill_in "Email",    with: customer.email
    fill_in "Password", with: customer.password
    click_button "Sign in"

    expect(current_path).to eq explore_path

    click_link "Photographer? Sign up here!"

    fill_in "Store Name", with: "Sandra Smith Photography"
    fill_in "Email",      with: "sandra@example.com"
    attach_file "Avatar",       "spec/fixtures/images/beach_van.jpg"
    attach_file "Header Image", "spec/fixtures/images/beach_van.jpg"

    click_button "Submit"

    expect(current_path).to eq profile_path
    expect(page).to have_content "Your application has been received."
  end
end
