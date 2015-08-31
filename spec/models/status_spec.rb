require 'rails_helper'

RSpec.describe Status, type: :model do
  it "has a capitalized first letter" do
    status = Status.create(name: "HELLO")
    expect(status.name).to eq("Hello")
  end
end
