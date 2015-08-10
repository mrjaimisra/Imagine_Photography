require "rails_helper"

RSpec.describe "the user", type: :model do
  let!(:user) {
    User.create(username: "Ronda",
                password: "Rousey")
  }

  context "a user" do
    it "is valid" do
      expect(user).to be_valid
    end

    it "is invalid without a username" do
      user.username = nil
      expect(user).to_not be_valid
    end

    it "is invalid without a password" do
      user.password = nil
      expect(user).to_not be_valid
    end

    xit "has a default role of 'default'" do
      expect(user.role).to eq "default"
    end
  end
end
