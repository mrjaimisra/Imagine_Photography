require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) {
    User.create(name: "Jen", email: "jerry@internet.com", password: "password")
  }
  let!(:registered) { Role.create }
  let!(:store_adm) { Role.create(name: "store_admin") }
  let!(:platform_adm) { Role.create(name: "platform_admin")}

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

  it "can be a store administrator" do
    user.roles << store_adm

    expect(user).to be_store_admin
  end

  it "can be a platform administrator" do
    user.roles << platform_adm

    expect(user).to be_platform_admin
  end

  it "can return a collection of registered_users" do
    user1 = User.create(name: 'Ted', email: "t@texas.com", password: 'password')
    user2 = User.create(name: 'Bee', email: "b@texas.com", password: 'password')
    user3 = User.create(name: 'Jai', email: "j@texas.com", password: 'password')

    expect(User.all.count).to eq 3
    expect(User.registered_users.count).to eq 3
  end

  it "can return a collection of store administrators" do
    user1 = User.create(name: 'Ted', email: "t@texas.com", password: 'password')
    user2 = User.create(name: 'Bee', email: "b@texas.com", password: 'password')
    user3 = User.create(name: 'Jai', email: "j@texas.com", password: 'password')

    user1.roles << store_adm
    user2.roles << store_adm

    expect(User.all.count).to eq 3
    expect(User.store_admins.count).to eq 2
  end

  it "can return a collection of platform administrators" do
    user1 = User.create(name: 'Ted', email: "t@texas.com", password: 'password')
    user2 = User.create(name: 'Bee', email: "b@texas.com", password: 'password')
    user3 = User.create(name: 'Jai', email: "j@texas.com", password: 'password')

    user1.roles << platform_adm
    user2.roles << platform_adm

    expect(User.all.count).to eq 3
    expect(User.platform_admins.count).to eq 2
  end
end
