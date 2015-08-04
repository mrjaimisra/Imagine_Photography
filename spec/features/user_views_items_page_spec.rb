require "rails_helper"

RSpec.describe "the items view", type: :feature do
  context "a user visits the items view" do
    it "displays all items" do
      Item.create(name: "Hamburger and fries", description: "delicious", price: 12)
      visit items_path

      within(".items-list") do
        within("#item-box") do
          expect(page).to have_content("Hamburger and fries")
        end
      end
    end

    it "views an items name, description, price and image" do
      Item.create(name: "Hamburger and fries", description: "delicious", price: 12)
      visit items_path

      within(".items-list") do
        within("#item-box") do
          expect(page).to have_content("Hamburger and fries")
          expect(page).to have_content("delicious")
          expect(page).to have_content("12")
        end
      end
    end
  end
end
