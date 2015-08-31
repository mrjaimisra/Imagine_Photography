RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.disable_monkey_patching!
  config.backtrace_exclusion_patterns << %r{/gems/}

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  # Paperclip cleanup for capybara
  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_files/"])
  end

  config.order = :random

  Kernel.srand config.seed

  if ENV["CI"]
    require "codeclimate-test-reporter"
    CodeClimate::TestReporter.start
  else
    require "simplecov"
    SimpleCov.start do
      add_filter "/spec/"
    end
  end
end
