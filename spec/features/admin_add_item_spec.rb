require "rails_helper"

RSpec.describe "an admin on their dashboards" do
  it "can access the form to add a new item" do
    register_admin
    sign_in

    visit "/admin/dashboard"
    click_link "Add New Meal"

    expect(current_path).to eq("/admin/items/new")
    expect(page).to have_content("Name")
    expect(page).to have_content("Description")
    expect(page).to have_content("Price")
    expect(page).to have_content("Category")
  end

  it "can submit a new item to the menu" do
    register_admin
    sign_in

    visit "/admin/dashboard"
    click_link "Add New Meal"

    expect(current_path).to eq("/admin/items/new")

    fill_in "Name", with: "Chicken Fingers"
    fill_in "Description", with: "Golden fried crispy battered chicken breast"
    fill_in "Price", with: "Priceless"
    fill_in "Image_URL", with: "Priceless"
    fill_in "Category", with: "Lunch"
    fill_in "Image URL", with: "http://thumb7.shutterstock.com/display_pic_with_logo/847900/156385361/stock-photo-breaded-chicken-fingers-156385361.jpg"
    click_button "Add Meal"

    visit menu_path
    expect(page).to have_content("Chicken Fingers")
    expect(page).to have_content("Golden fried crispy battered chicken breast")
    expect(page).to have_content("Priceless")
    expect(page).to have_content("Lunch")
    expect(page).to have_content("http://thumb7.shutterstock.com/display_pic_with_logo/847900/156385361/stock-photo-breaded-chicken-fingers-156385361.jpg")
  end

  private

  def register_admin
    register_user
    user = User.find_by(username: "Jason")
    user.update_attributes(role: 1)
  end
end