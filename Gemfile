source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
git_source(:gitlab) { |repo| "https://10.0.0.69/#{repo}.git"}

ruby '3.0.0'

# Custom Gem Start
gem 'rack-attack'
gem 'dotenv-rails', :groups => [:development, :test]
gem 'rqrcode'
gem 'devise-two-factor'
gem "valid_email2"
gem 'rpush'
gem 'rails_admin', '~> 2.0.2'
gem 'progress_job'
gem 'jquery-atwho-rails'
gem 'coffee-rails'
gem 'pry'
gem 'faker'
gem 'carrierwave-video-thumbnailer'
gem 'carrierwave_backgrounder', github: 'EDealerDirect/carrierwave_backgrounder'
gem 'carrierwave-video'
gem 'sidekiq'
gem 'jquery-rails'
gem 'image_optim'
gem 'image_optim_pack'
gem 'streamio-ffmpeg', github: 'streamio/streamio-ffmpeg'
gem 'will_paginate'
gem 'impressionist'
gem 'simple_form'
gem 'kaminari'
gem 'elasticsearch'
gem 'searchkick'
gem 'jwt'
gem 'simple_token_authentication'
gem 'responders'
gem 'grape-active_model_serializers'
gem 'rack-cors'
gem 'grape'
gem 'nprogress-rails'
gem 'file_validators'
gem 'clamby'
gem 'friendly_id', '~> 5.2.4'
gem 'therubyracer', platforms: :ruby
gem 'aws-sdk-s3'
gem 'active_storage_validations'
gem 'jcrop-rails-v2'
gem 'mini_magick'
gem 'image_processing'
gem 'activestorage'
gem 'devise'
# Custom Gem End
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
gem 'fog-aws'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
