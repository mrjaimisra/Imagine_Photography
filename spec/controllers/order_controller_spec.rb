require 'rails_helper'


RSpec.describe "Order Controller", type: :controller do
  describe "Post #orders" do
    context "no current session" do
      let(:user) { User.create(username: "Optimus", password: "Prime") }
      let!(:item) { Item.create(name:        "Hamburger and fries",
                                description: "delicious",
                                price:       12,
                                image_url:   test_image_url,
                                category_id: 1) }

      it "sets the flash" do
        session[:cart] = { item.id => 1 }

        is_expected.to set_the_flash(:danger).to("Sign In to complete your order, Dinners almost ready!")
      end
    end
  end
end
