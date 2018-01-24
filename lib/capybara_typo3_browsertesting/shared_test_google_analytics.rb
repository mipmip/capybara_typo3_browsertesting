module CapybaraTypo3Browsertesting
  module SharedTestsGoogleAnalytics
    def test_home_page_ua_code
      visit '/'
      assert page.has_selector?('script', visible: false, text: CapybaraTypo3Browsertesting.google_analytics_code)
    end
  end
end
