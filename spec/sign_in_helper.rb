def sign_in_customer
  visit root_path

  within(".navbar") do
    click_link "Sign in"
  end

  fill_in "Email", with: customer.email
  fill_in "Password", with: customer.password
  click_button "Sign in"
end

def sign_in_store_admin
  visit root_path

  within(".navbar") do
    click_link "Sign in"
  end

  fill_in "Email", with: store_admin.email
  fill_in "Password", with: store_admin.password
  click_button "Sign in"
end