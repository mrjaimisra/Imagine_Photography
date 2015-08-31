Fabricator(:photo) do
  before_validation {
    Store.create(name: "My Store", email: "hello@example.com")
  }

  name             Faker::Book.title
  description      Faker::Lorem.sentence(4)
  price            Faker::Commerce.price + 1
  image_file_name  "beach_van.jpg"
  store_id         1
  category_id      1
  status           1
end
