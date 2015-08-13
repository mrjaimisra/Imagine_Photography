require "rails_helper"

RSpec.describe "a category" do
  let!(:category) { Category.create(name: "Breakfast") }

  it "is valid" do
    expect(category).to be_valid
  end

  it "is invalid without a name" do
    category.name = nil
    expect(category).to_not be_valid
  end

  it "is invalid if it has a duplicate name" do
    other_category = Category.create(name: "Breakfast")
    expect(other_category).to_not be_valid
  end

  it "is invalid if it has spaces in the name" do
    spacey_category = Category.new(name: "break fast")
    expect(spacey_category).to_not be_valid
  end

  it "is invalid if it has non-alphanumeric characters in the name" do
    spacey_category = Category.new(name: "break*fast")
    expect(spacey_category).to_not be_valid
  end

  it "capitalizes the name before saving it to the database" do
    status = Category.create(name: "HELLO")
    expect(status.name).to eq("Hello")
  end
end
