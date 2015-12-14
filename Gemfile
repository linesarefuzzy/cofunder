source 'https://rubygems.org'

gem 'rails', '~> 4.2.0'
gem 'mysql2'
gem 'json'

# Assets
gem 'sass-rails'
gem 'coffee-rails'
gem 'therubyracer', :platforms => :ruby
gem 'uglifier'#, '>= 1.0.3'
gem 'jquery-rails'

# Devise (user auth)
gem 'devise'

# Pagination
gem 'will_paginate', '~> 3.0.4'
gem 'will_paginate-bootstrap'

# Remove UTF8 parameter from GET forms
gem 'utf8_enforcer_workaround'

# Slim template language
gem 'slim'

# Cron jobs
gem 'whenever', require: false

# Icons
gem 'font-awesome-rails'

# Internationalization
gem 'rails-i18n'#, '~> 3.0.0'

# Translate urls
gem 'route_translator'

group :development do
  # Deployment
  gem 'capistrano',  '~> 3.1'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-passenger'

  # To use debugger
  gem 'byebug'

  # Report number of queries in server log
  gem 'sql_queries_count'

  # Watches for inefficient queries and recommends eager loading
  gem 'bullet'

  # Auto-reload pages in browser when changes saved
  gem 'guard', '>= 2.2.2',       require: false
  gem 'guard-livereload',        require: false
  gem 'rack-livereload'
  gem 'rb-fsevent',              require: false

  # Console output
  gem 'hirb'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'faker'
  gem 'capybara'
  gem 'simplecov'
end

group :doc do
  gem 'rails-erd'
end
