source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2', '~> 0.3.10'
gem 'net-ssh', '~> 2.9.2'
gem 'json'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'

  # Twitter bootstrap
  # gem 'bootstrap-sass', '~> 3.2.0'
  # gem 'sprockets-rails', '=2.0.0.backport1'
  # gem 'sprockets', '=2.2.2.backport2'
  # gem 'sass-rails', github: 'guilleiguaran/sass-rails', branch: 'backport'
end

gem 'jquery-rails'
# gem 'jquery-ui-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'
group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'faker'
  gem 'capybara'
  gem 'simplecov'
  gem 'awesome_print'
end

group :development do
  # Deployment
  gem 'capistrano',  '~> 3.1'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-passenger'

  # To use debugger
  gem 'debugger'

  # Report number of queries in server log
  gem 'sql_queries_count'

  # Watches for inefficient queries and recommends eager loading
  gem 'bullet'
  # gem 'ruby-growl'
  gem 'rails-erd'

  # Auto-reload pages in browser when changes saved
  gem 'guard', '>= 2.2.2',       require: false
  gem 'guard-livereload',        require: false
  gem 'rack-livereload'
  gem 'rb-fsevent',              require: false

  # Console output
  gem 'hirb'
end

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
gem 'rails-i18n', '~> 3.0.0'

# Translate urls
gem 'route_translator'
