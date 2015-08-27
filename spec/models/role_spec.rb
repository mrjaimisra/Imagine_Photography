require 'rails_helper'

RSpec.describe Role, type: :model do
  it "exists" do
    assert Role
  end

  it "has a default name of registered_user" do
    role = Role.create
    expect(role.name).to eq("registered_user")
  end

  it "has a unique name" do
    role = Role.create
    expect(role.name).to eq("registered_user")

    role = Role.create(name: "registered_user")
    expect(role).not_to be_valid
  end
end
