require "rails_helper"

RSpec.describe "an admin on their dashboards" do
  let!(:user) { Fabricate(:user) }
  let!(:item) { Fabricate(:item) }

  before(:each) do
    sign_in(user)
    user.update_attribute("role", 1)
  end

  it "can see all items" do
    visit "/admin/dashboard"
    click_link "View All Items"

    expect(current_path).to eq("/admin/items")
    expect(page).to have_content("Item")
    expect(page).to have_content("Description")
    expect(page).to have_content("Price")
    expect(page).to have_content("Status")
    expect(page).to have_content("Hamburger")
    expect(page).to have_content("Nice and juicy")
    expect(page).to have_content("12")
  end
end
