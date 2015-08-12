require "rails_helper"

# As an admin
# When I visit "admin/items"
# And I click "Edit"
# Then my current path should be
# And I should be able to upate title, description, image, and status

RSpec.describe "an admin" do
  let!(:admin) { Fabricate(:user) }
  let!(:item) { Fabricate(:item) }

  context "visits admin/items" do
    before do
      admin.update_attribute(:role, 1)
      sign_in(admin)
      visit admin_items_path
    end

    context "clicks the Edit link" do
      before do
        click_link "Edit"
      end

      it "shows the edit page for that item" do
        expect(current_path).to eq("/admin/items/#{item.id}/edit")
      end

      it "updates the name" do
        fill_in "Name", with: "New Name"
        click_button "Update Meal"

        expect(current_path).to eq(admin_items_path)
        expect(page).to have_content("New Name")
      end

      it "updates the description" do
        fill_in "Description", with: "New Description"
        click_button "Update Meal"

        expect(page).to have_content("New Description")
      end

      it "updates the price " do
        fill_in "Price", with: 5
        click_button "Update Meal"

        expect(page).to have_content(5)
      end

      it "updates the image_url" do
        fill_in "Image url", with: "new_image_url"
        click_button "Update Meal"

        expect(page).to have_css("img[src*='images/new_image_url']")
        end

      it "updates the status" do
        fill_in "Status", with: "retired"
        click_button "Update Meal"

        expect(page).to have_content("retired")
      end
    end
  end
end