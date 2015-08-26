Fabricator(:user) do
  name     Faker::Name.name
  username Faker::Internet.email
  password "password"
  phone_number Faker::PhoneNumber.phone_number
  pass_word = Faker::Internet.password
  password pass_word
  password_confirmation pass_word
  role { %w(default business_admin photographer site_admin).sample }
end
