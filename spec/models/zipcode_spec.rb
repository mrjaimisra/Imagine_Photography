require "rails_helper"

RSpec.describe "the zipcode filter" do
  it "is initialized with a zipcode" do
    expect(Zipcode.new("12345").code).to eq "12345"
  end

  it "has allowed zipcodes" do
    expect(Zipcode.new("12345").zipcodes.count).to eq 5
  end

  it "returns true for allowed zipcodes" do
    zipcode = "12345"
    expect(Zipcode.new("12345").allowed?).to eq true
  end
end
