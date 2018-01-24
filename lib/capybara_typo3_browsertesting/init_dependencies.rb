require 'minitest'
require 'minitest/unit'
require 'minitest/autorun'
require 'minitest/pride'
require 'fileutils'
require 'capybara/dsl'
require 'selenium-webdriver'

timeout = (ENV['CI'] || ENV['CI_SERVER']) ? 60 : 30

Capybara.register_driver :chrome do |app|

  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    # This enables access to logs with `page.driver.manage.get_log(:browser)`
    loggingPrefs: {
      browser: "ALL",
      client: "ALL",
      driver: "ALL",
      server: "ALL"
    }
  )

  options = Selenium::WebDriver::Chrome::Options.new

  options.add_argument("window-size=1240,1400")

  # Chrome won't work properly in a Docker container in sandbox mode
  options.add_argument("no-sandbox")

  # Run headless by default unless CHROME_HEADLESS specified
  unless ENV['CHROME_HEADLESS'] =~ /^(false|no|0)$/i
    options.add_argument("headless")

    # Chrome documentation says this flag is needed for now
    # https://developers.google.com/web/updates/2017/04/headless-chrome#cli
    options.add_argument("disable-gpu")
  end

  # Disable /dev/shm use in CI. See https://gitlab.com/gitlab-org/gitlab-ee/issues/4252
  options.add_argument("disable-dev-shm-usage") if ENV['CI'] || ENV['CI_SERVER']

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities,
    options: options
  )

end

Capybara.javascript_driver = :chrome
Capybara.default_max_wait_time = timeout
Capybara.ignore_hidden_elements = false
Capybara.app_host = ENV['BASEURL']
Capybara.default_driver = :chrome
