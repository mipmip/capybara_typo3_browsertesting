require 'uri/http'
require "capybara_typo3_browsertesting/version"
require "capybara_typo3_browsertesting/init_dependencies"
require "capybara_typo3_browsertesting/shared_test_header"
require "capybara_typo3_browsertesting/shared_test_google_analytics"
require "capybara_typo3_browsertesting/shared_test_backend"
require "capybara_typo3_browsertesting/reports"

module CapybaraTypo3Browsertesting
  class << self

    attr_accessor :google_analytics_code
    attr_accessor :typo3_major_version
    attr_accessor :typo3_backend_login, :typo3_backend_password
    attr_accessor :typo3_frontend_login, :typo3_frontend_password

    def configure
      yield self
    end
  end
end

module Minitest
  module TYPO3
    class Test < Minitest::Test
      include Capybara::DSL

      def initialize(name = nil)
        print "\nRunning on #{Capybara.app_host} test case: #{name} "
        @test_name = name
        super(name) unless name.nil?
      end

      def setup
      end

      def teardown
        unless passed?
          uri = URI.parse(Capybara.app_host)
          domain = PublicSuffix.parse(uri.host)
          system("mkdir -p testout/#{domain}")
          imgname = "testout/#{domain}/testname-#{@test_name}-#{Time.now.strftime('%Y%m%d-%H%M%S')}.png"
          p imgname
          page.save_screenshot imgname, full: true
        end
      end
    end
  end
end
