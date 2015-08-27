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

  it "is invalid without a name" do
    user.name = nil
    expect(user).to_not be_valid
  end

  it "is invalid without an email" do
    user.email = nil
    expect(user).to_not be_valid
  end

  it "is invalid without a password" do
    user.password = nil
    expect(user).to_not be_valid
  end

  it "is invalid with a name that is too long" do
    user.name = "a" * 51
    expect(user).to_not be_valid
  end

  it "is invalid with an email that is too long" do
    user.email = "a" * 244 + "@example.com"
    expect(user).to_not be_valid
  end

  it "is invalid with a password that is too long" do
    user.password = "p" * 51
    expect(user).to_not be_valid
  end

  it "is valid with a properly-formatted email" do
    valid_addresses = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org
                      first.last@foo.io alice+bob@baz.cn tyler@me.net)
    valid_addresses.each do |valid_address|
      user.email = valid_address
      expect(user).to be_valid
    end
  end

  it "is invalid without a properly-formatted email" do
    invalid_addresses = %w(user@example,com USER_at_foo.COM user.name@example.
                      first.last@foo_io tyler@you_me.net)
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).to_not be_valid
    end
  end

  it "is invalid without a unique email" do
    user.save
    second_user = User.new(name: "Jai",
                           email: "Jerry@internet.com",
                           password: "password2")

    expect(second_user).to_not be_valid
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
