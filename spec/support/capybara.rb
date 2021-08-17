Capybara.register_driver :remote_chrome do |app|
  url = ENV['SELENIUM_DRIVER_URL']
  caps = ::Selenium::WebDriver::Remote::Capabilities.chrome(
    'goog:chromeOptions' => {
      'args' => [
        'no-sandbox',
        'headless',
        'disable-gpu',
        'window-size=1680,1050'
      ]
    }
  )
  Capybara::Selenium::Driver.new(app, browser: :remote, url: url, desired_capabilities: caps)
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    if ENV["SELENIUM_DRIVER_URL"].present?
      driven_by :selenium, using: :chrome, options: {
        browser: :remote,
        url: ENV.fetch("SELENIUM_DRIVER_URL"),
        desired_capabilities: :chrome
      }
    else
      driven_by :selenium_chrome_headless
    end
  end
end
