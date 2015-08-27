require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) {
    User.create(name: "Jen", email: "jerry@internet.com", password: "password")
  }

  before do
    Role.create
  end

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

  it "has a default role of 'registered_user'" do
    expect(user).to be_registered_user
  end
end
