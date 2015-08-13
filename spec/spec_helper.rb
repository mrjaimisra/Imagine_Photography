RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.disable_monkey_patching!

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  config.order = :random

  Kernel.srand config.seed

  require "webmock/rspec"
  WebMock.disable_net_connect!(allow_localhost: true)

  config.before(:each) do
    stub_request(:get, /maps.googleapis.com/)
      .with(headers: { "Accept" => "*/*", "User-Agent" => "Ruby" })
      .to_return(status: 200, body: "stubbed response", headers: {})
  end

  def test_image_url
    "http://i.livescience.com/images/i/000/048/850/i02/capybara-02.jpg?1324347800"
  end

  def sign_in(user)
    visit root_path

    click_link "Sign In"
    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Sign In"
  end

  if ENV["CI"]
    require "codeclimate-test-reporter"
    CodeClimate::TestReporter.start
  else
    require "simplecov"
    SimpleCov.start
  end

end
