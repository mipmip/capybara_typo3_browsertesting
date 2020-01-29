module CapybaraTypo3Browsertesting

  module SharedTestsBackend

    def test_backend
      visit '/typo3'

      #t3-username
      within("#typo3-login-form") do
        fill_in 't3-username', :with => CapybaraTypo3Browsertesting.typo3_frontend_login
        fill_in 't3-password', :with => CapybaraTypo3Browsertesting.typo3_backend_password
      end
      click_button 't3-login-submit'

      if CapybaraTypo3Browsertesting.typo3_major_version == '7.6'
        assert page.has_selector?('#typo3-cms-backend-backend-toolbaritems-livesearchtoolbaritem')

      elsif CapybaraTypo3Browsertesting.typo3_major_version == '9.5'
        assert page.has_selector?('#t3js-modal-backendlocked')
      end
    end

  end

end
