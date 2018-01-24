module CapybaraTypo3Browsertesting

  module SharedTestsBackend

    def test_backend
      visit '/typo3'

      within("#typo3-login-form") do
        fill_in 't3-username', :with => CapybaraTypo3Browsertesting.typo3_backend_login
        fill_in 't3-password', :with => CapybaraTypo3Browsertesting.typo3_backend_password
      end
      click_button 't3-login-submit'

      # 7.6
      assert page.has_selector?('#typo3-cms-backend-backend-toolbaritems-livesearchtoolbaritem')
    end

  end

end
