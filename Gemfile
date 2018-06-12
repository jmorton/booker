source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.0'

gem 'turbolinks', '~> 5.1.1'

gem 'webpacker', '~> 3.5'

gem 'image_processing', '~> 1.2'

gem 'ruby-vips', '~> 2.0.12'

# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'

# Use Puma as the app server
gem 'puma', '~> 3.11'

# 12 Factor app related gems...
gem 'dotenv-rails', '~> 2.4.0', groups: [:development, :test]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Provide support for converting to and from ISO8601 times and intervals.
gem 'iso8601', '~> 0.10.1'

# Keeps track of any `audited` model changes
gem 'audited', '~> 4.7'

# Enable geocoding of units (and spatial querying)
gem 'geocoder', '~> 1.4.9'

# Natural language parsing of time
gem 'chronic', '~> 0.10.2'

# Authentication support
gem 'omniauth', '~> 1.8.1'
gem 'omniauth-google-oauth2'
gem 'omniauth-github'
gem 'omniauth-twitter'
gem 'omniauth-discord'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Rerun tests automatically
  gem 'guard'
  gem 'guard-minitest'
  # Use Foreman for backing services
  gem 'foreman'
  # DEVEX
  gem 'pry-rails'
  gem 'rubocop', require: false
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'rspec', '~> 3.7'
  gem 'database_cleaner'
  gem 'factory_bot_rails', '~> 4.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
