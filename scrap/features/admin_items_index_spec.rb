require "rails_helper"

RSpec.describe "an admin on their dashboards" do
  let!(:user) { Fabricate(:user) }
  let!(:item) { Fabricate(:item) }
  let!(:second_item) { item }

  before(:each) do
    sign_in(user)
    user.update_attribute("role", 1)
  end

  it "can see all photos" do
    second_item.update_attributes(name: "Burger", status: 1)

    visit "/admin/dashboard"
    click_link "View All Meals"

    expect(current_path).to eq "/admin/photos"
    expect(page).to have_content "Meal"
    expect(page).to have_content "Description"
    expect(page).to have_content "Price"
    expect(page).to have_content "Status"

    expect(page).to have_content item.name
    expect(page).to have_content item.description
    expect(page).to have_content item.price.to_s
    expect(page).to have_content item.status

    expect(page).to have_content second_item.name
    expect(page).to have_content second_item.status
  end
end
