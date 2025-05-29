# features/support/env.rb
require 'cucumber/rails'
require 'capybara/cucumber'
require 'capybara/rails'

# Make Rails URL helpers available
World(Rails.application.routes.url_helpers)

# Configure Capybara
Capybara.default_driver = :selenium_chrome_headless
Capybara.javascript_driver = :selenium_chrome_headless

# Configure database cleaner
DatabaseCleaner.strategy = :truncation

Cucumber::Rails::Database.javascript_strategy = :truncation

# Configure Chrome options for headless testing
Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,1400')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
