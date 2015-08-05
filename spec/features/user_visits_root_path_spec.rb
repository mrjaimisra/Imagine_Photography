require "rails_helper"

RSpec.describe "the landing page", type: :feature do
  context "a user" do
    it "can access the root path" do
      visit root_path
      expect(current_path).to eq(root_path)
    end
  end
end
