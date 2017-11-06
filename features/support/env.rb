require 'rubygems'
require 'bundler/setup'
require 'capybara/cucumber'


Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :selenium
  config.app_host = 'https://www.google.com' # change url
end
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
