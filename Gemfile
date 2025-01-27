source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.3.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  gem 'factory_bot_rails'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'spring-commands-rspec'

  gem 'capistrano'
  gem 'capistrano3-unicorn'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'

  gem 'bullet'
  gem 'pry-byebug'
  gem 'pry-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '~> 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # 静的解析ツール
  gem 'pre-commit'
  gem 'rubocop'
  gem 'rubocop-rails'

  # ER図自動生成
  gem 'rails-erd'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'database_cleaner'
  gem 'launchy'
  gem 'webdrivers', require: !ENV['SELENIUM_DRIVER_URL']
end

group :production do
  gem 'unicorn', '5.4.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data'

# railsアプリからのMySQLへの接続
# https://qiita.com/fuku_tech/items/a380ebb1fd156c14c25b
gem 'dotenv-rails'
# ログイン機能と日本語化
# https://kitsune.blog/rails-devise
gem 'devise'
gem 'devise-i18n'
gem 'devise-i18n-views'
# プロフィール画像処理
# https://techtechmedia.com/carrierwave-minimagick-image/
gem 'carrierwave'
# 画像自動調整
gem 'mini_magick'
# bootstrap導入(techpitgram)
# https://qiita.com/kazutosato/items/d47b7705ee545de4cb1a
gem 'bootstrap', '~> 4.3.1'
gem 'devise-bootstrap-views', '~> 1.0'
gem 'jquery-rails'
gem 'uglifier'
# Font awesome
gem 'font-awesome-sass'
gem 'mini_racer'
# 検索機能
gem 'ransack'
# カレンダー機能
gem 'simple_calendar', '~> 2.0'
# フェイクデモデータ
gem 'faker'
# ページネーション
gem 'kaminari'
