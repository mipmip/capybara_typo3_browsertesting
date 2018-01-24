require 'minitest'
require 'minitest/unit'
require 'minitest/autorun'
require 'minitest/pride'
require 'fileutils'
require 'capybara/dsl'
#require "capybara/poltergeist"
#require "phantomjs"

require 'selenium-webdriver'

Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w[headless disable-gpu no-sandbox]
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

#Capybara.javascript_driver = :chrome
Capybara.configure do |config|
  config.javascript_driver = :chrome
  config.default_driver = :chrome
  config.ignore_hidden_elements = false
  config.app_host   = ENV['BASEURL']
end


#Capybara.configure do |config|
  #config.javascript_driver = :poltergeist
  #config.default_driver = :poltergeist
  #config.ignore_hidden_elements = false
  #config.app_host   = ENV['BASEURL']
#end

#PHANTOMJS_OPTIONS = [
  #'--webdriver-logfile=/dev/null',
  #'--load-images=yes',
  #'--debug=no',
  #'--ignore-ssl-errors=yes',
  #'--ssl-protocol=TLSv1'
#]
#PHANTOMJS_URL_BLACKLIST = [
  #'youtube.com', # the youtube embed player doesn't support phantomjs
  #'ytimg.com'
#]

#Capybara.register_driver :poltergeist do |app|
  #Capybara::Poltergeist::Driver.new(app,
                                    #debug: false,
                                    #js_errors: false, # Use true if you are really careful about your site
                                    #phantomjs_logger: '/dev/null',
                                    #timeout: 60,
                                    #:phantomjs_options => PHANTOMJS_OPTIONS,
                                    #url_blacklist: PHANTOMJS_URL_BLACKLIST,
                                    #window_size: [1920,1080]
                                   #)
#end


