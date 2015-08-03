require "rails_helper"

RSpec.describe "the items view", type: :feature do
  context "a user visits the items view" do
    it "displays all items" do
      Item.create(name: "Hamburger and fries", description: "delicious", price: 12)
      visit items_path
      within(".items-list") do
        within(".item-box") do
          expect(page).to have_content("Hamburger and fries")
        end
      end
    end
  end
end
