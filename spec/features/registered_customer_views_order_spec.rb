require 'rails_helper'

RSpec.feature "Registered customer views specific order", type: :feature do
  before do
    build_roles
  end
  let!(:category)     { Category.create(name: "People") }
  let!(:photographer) { Fabricate(:store) }
  let!(:photo)        { photographer.photos.create(
                        name: "My Photo",
                        description: "My description",
                        price:       "120.00",
                        category_id: category.id,
                        status: 1,
                        image: File.open("spec/fixtures/images/beach_van.jpg")
                     ) }
  let!(:user) { Fabricate(:user) }

  scenario "successfully" do
    status = Status.create!(name: "completed")
    order = Order.create!(user_id: user.id, status_id: status.id)

    order.photos << photo
    user.orders << order

    visit root_path
    click_link "Sign in"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"

    click_on "Orders"

    expect(user.orders.count).to eq(1)

    click_on "View"

    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content("Order ##{order.id}")
    expect(page).to have_content("Status: Completed")
    expect(page).to have_content("#{photo.name}")
    expect(page).to have_content("#{photo.price}")
  end
end
