module CapybaraTypo3Browsertesting
  module SharedTestsHeader
    def test_home_page_base_url
      visit '/'
      assert page.has_xpath?("//base[@href='#{ENV['BASEURL']}/']")
    end
  end
end
