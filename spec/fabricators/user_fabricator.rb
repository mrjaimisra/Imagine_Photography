Fabricator(:user) do
  name                  Faker::Name.name
  email                 Faker::Internet.email
  avatar_file_name      "jorge.jpg"
  pass_word =           Faker::Internet.password
  password              pass_word
  password_confirmation pass_word
end
