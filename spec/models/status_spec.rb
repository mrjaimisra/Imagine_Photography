require 'rails_helper'

RSpec.describe Status, type: :model do
  xit "write a new test for this" do
    status = Status.create(name: "HELLO")
    expect(status.name).to eq("Hello")
  end
end
