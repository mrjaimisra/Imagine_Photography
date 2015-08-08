require 'rails_helper'


RSpec.describe OrdersController, type: :controller do
  describe "Post #orders" do
    context "no current session" do
      # let(:user) { User.create(username: "Optimus", password: "Prime") }
      let!(:item) { Item.create(name:        "Hamburger and fries",
                                description: "delicious",
                                price:       12,
                                image_url:   test_image_url,
                                category_id: 1) }


      xit "sets the flash" do
        session[:cart] = { item.id => 1 }
        post "/orders"
        is_expected.to set_the_flash(:danger).to("Sign In to complete your order, Dinners almost ready!")
      end
    end
  end
end
