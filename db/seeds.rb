# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

name = %w(Pizza Hamburger Hotdog Chilli Hummus Vanilla Chocolate Beans Steak Rice)
description = "Very tasty."
image_url = "http://i.livescience.com/images/i/000/048/850/i02/capybara-02.jpg?1324347800"
category_id = rand(3)

name.each do |name|
  price = rand(15)
  Item.create(name: name, description: description, price: price, image_url: image_url, category_id: category_id)
end
