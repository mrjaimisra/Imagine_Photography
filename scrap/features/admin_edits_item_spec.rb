require "rails_helper"

RSpec.describe "an admin" do
  let!(:admin) { Fabricate(:user) }
  let!(:item) { Fabricate(:item) }
  let!(:category) { Category.create(name: "Lunch") }

  context "visits admin/photos" do
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
        expect(current_path).to eq("/admin/photos/#{item.id}/edit")
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
        select "Retired", from: "item[status]"
        click_button "Update Meal"

        expect(page).to have_content("retired")
      end
    end
  end
end
