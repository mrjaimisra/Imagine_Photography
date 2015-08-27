Fabricator(:photo) do
  name        Faker::Book.title
  description Faker::Lorem.sentence(4)
  price       Faker::Commerce.price + 1
  image_url   "hello.jpg"
  category_id 1
  status      1
end
