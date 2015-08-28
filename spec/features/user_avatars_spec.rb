require 'rails_helper'

RSpec.feature "User", type: :feature do
  let(:user) { Fabricate.build(:user) }
  scenario 'creates account with avatar' do
    visit sign_up_path

    fill_in "Name", with: user.name
    fill_in "Email", with: user.email
    attach_file "Avatar", "spec/fixtures/images/headshot.jpg"
    click_on "Create account"
  end
end
