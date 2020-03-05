require "mail"

module CapybaraTypo3Browsertesting
  module Reports

    def create_responsive_report resp_conf, domain, run_method
      workdir = get_workdir domain
      i = 1

      resp_conf['pages'].each do|testpage|

        url = "#{resp_conf['base']}#{testpage['url']}"
        print "visiting: #{url}\n"
        visit url

        width = page.execute_script("return Math.max(document.body.scrollWidth,document.body.offsetWidth,document.documentElement.clientWidth,document.documentElement.scrollWidth,document.documentElement.offsetWidth);")
        height = page.execute_script("return Math.max(document.body.scrollHeight,document.body.offsetHeight,document.documentElement.clientHeight,document.documentElement.scrollHeight,document.documentElement.offsetHeight);")

        width = 2000 if width > 2000

        window = Capybara.current_session.current_window
        window.resize_to(width, height)
        window.maximize

        if(testpage['wait'])
          sleep testpage['wait'].to_i
        else
          sleep resp_conf['default_wait'].to_i
        end

        iframe_count = 5
        iframe_count = resp_conf['iframe_count'] if resp_conf.has_key? 'iframe_count'
        1.upto(iframe_count) do |ii|

          page.driver.switch_to_frame(page.find("#iframe#{ii}"))
          if run_method
            send(run_method)
          end

          clickawaycookie
          Capybara.current_session.switch_to_window window
        end

        page.save_screenshot  "#{workdir}/page-#{i}.png", full: true
        i += 1
      end

      merge_to_pdf resp_conf['jpg_quality'], domain
      send_report resp_conf['mail'], domain unless resp_conf.has_key? 'skip_headless' and resp_conf['skip_mail']
    end

    def get_workdir domain
      workdir = "testout/#{domain}/reponsive"
      system("mkdir -p #{workdir}")
      workdir
    end

    def merge_to_pdf jpg_quality, domain
      workdir = get_workdir domain
      system("cd #{workdir} && mogrify -quality #{jpg_quality} -format jpg *.png")
      system("cd #{workdir} && rm *.png")
      system("cd #{workdir} && convert *.jpg responsive_report.pdf")
      system("cd #{workdir} && rm *.jpg")
    end

    def send_report config, domain

      workdir = get_workdir domain

      options = { :address              => config['server'],
                  :port                 => config['port'],
                  :user_name            => config['username'],
                  :password             => config['password'],
                  :authentication       => 'login',
                  :enable_starttls_auto => true  }

      Mail.defaults do
        delivery_method :smtp, options
      end

      mail = Mail.new do
        from     config['from']
        to       config['to']
        subject  config['subject']
        body     config['body']
        add_file :filename => config['report_name'], :content => File.read("#{workdir}/responsive_report.pdf")
      end

      mail.deliver!
    end

  end
end
