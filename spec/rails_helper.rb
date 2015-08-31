ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'role_helper'
require 'category_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'database_cleaner'
require 'selenium-webdriver'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end
  config.infer_spec_type_from_file_location!
end
