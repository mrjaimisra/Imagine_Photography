require "rails_helper"

RSpec.describe "an admin on their dashboards" do
  let!(:user) { Fabricate(:user, role: 1) }

  before(:each) do
    sign_in(user)

    Category.create(name: "breakfast")
    Category.create(name: "lunch")
    Category.create(name: "dinner")
  end

  it "can access the form to add a new item" do
    expect(current_path).to eq menu_path

    visit "/admin/dashboard"
    click_link "Add New Meal"

    expect(current_path).to eq("/admin/items/new")
    expect(page).to have_content("Name")
    expect(page).to have_content("Description")
    expect(page).to have_content("Price")
    expect(page).to have_content("Category")
  end

  it "can submit a new item to the menu" do

    visit "/admin/dashboard"
    click_link "Add New Meal"

    expect(current_path).to eq("/admin/items/new")

    fill_in "Name", with: "Chicken Fingers"
    fill_in "Description", with: "Golden fried crispy battered chicken breast"
    fill_in "Price", with: "14"
    fill_in "Image", with: test_image_url
    select "lunch", from: "item[category]"
    click_button "Add Meal"

    visit menu_path

    expect(page).to have_content("Chicken Fingers")
    expect(page).to have_content("Golden fried crispy battered chicken breast")
    expect(page).to have_content("14")
  end

  it "cannot submit an order without a name" do
    visit "/admin/dashboard"
    click_link "Add New Meal"

    expect(current_path).to eq("/admin/items/new")

    fill_in "Name", with: ""
    fill_in "Description", with: "Golden fried crispy battered chicken breast"
    fill_in "Price", with: "14"
    fill_in "Image", with: test_image_url
    select "lunch", from: "item[category]"
    click_button "Add Meal"

    expect(current_path).to eq("/admin/items")
    expect(page).to have_content("Name can't be blank")
  end

  it "cannot submit an order without a description" do
    visit "/admin/dashboard"
    click_link "Add New Meal"

    expect(current_path).to eq("/admin/items/new")

    fill_in "Name", with: "Chicken Fingers"
    fill_in "Description", with: ""
    fill_in "Price", with: "14"
    fill_in "Image", with: test_image_url
    select "lunch", from: "item[category]"
    click_button "Add Meal"

    expect(current_path).to eq("/admin/items")
    expect(page).to have_content("Description can't be blank")
  end

  it "cannot submit an order without selecting a category" do
    visit "/admin/dashboard"
    click_link "Add New Meal"

    expect(current_path).to eq("/admin/items/new")

    fill_in "Name", with: "Chicken Fingers"
    fill_in "Description", with: "Golden fried crispy battered chicken breast"
    fill_in "Price", with: "14"
    fill_in "Image", with: ""
    click_button "Add Meal"

    expect(current_path).to eq("/admin/items")
    expect(page).to have_content("Category must be selected")
  end
end
