require 'rails_helper'

RSpec.describe Status, type: :model do
  it "capitalizes the name before saving it to the database" do
    status = Status.create(name: "HELLO")
    expect(status.name).to eq("Hello")
  end
end
