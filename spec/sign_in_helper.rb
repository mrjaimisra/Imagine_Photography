def sign_in_customer
  visit root_path

  within(".navbar") do
    click_link "Sign in"
  end

  fill_in "Email", with: customer.email
  fill_in "Password", with: customer.password
  click_button "Sign in"
end