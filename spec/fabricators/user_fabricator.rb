Fabricator(:user) do
  name                  Faker::Name.name
  email                 Faker::Internet.email
  password              "password"
  pass_word =           Faker::Internet.password
  password              pass_word
  password_confirmation pass_word
end
