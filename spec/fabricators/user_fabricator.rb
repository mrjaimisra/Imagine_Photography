Fabricator(:user) do
  name                  Faker::Name.name
  email                 Faker::Internet.email
  avatar                Faker::Avatar.image
  # header                "https://images.unsplash.com/photo-1438755582627-221038b62986?q=80&fm=jpg&s=ce1a984f1ac11887a5d5569ebbce53fb"
  password              "password"
  pass_word =           Faker::Internet.password
  password              pass_word
  password_confirmation pass_word
end
