
def sign_in(user)
  visit root_path

  click_link "Sign In"
  fill_in "Username", with: user.username
  fill_in "Password", with: user.password
  click_button "Sign In"
end
