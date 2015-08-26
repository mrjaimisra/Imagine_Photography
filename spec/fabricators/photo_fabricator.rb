Fabricator(:photo) do
  name        Faker::Book.title 
  description Faker::Lorem.sentence(4) 
  price       Faker::Commerce.price 
  image_url   "hello.lpg"
  category_id 1
  status      1
end
