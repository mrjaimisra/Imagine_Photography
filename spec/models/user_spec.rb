require "rails_helper"

RSpec.describe "the user", type: :model do
  context "a user" do
    let(:user) { Fabricate(:user) }

    it "is valid" do
      expect(user).to be_valid
    end

    it "is invalid without an email" do
      user.email = nil
      expect(user).to_not be_valid
    end

    it "is invalid without a password" do
      user.password = nil
      expect(user).to_not be_valid
    end

    it "has a default role of 'default'" do
      expect(user.role).to eq "default"
    end
  end
end
