source 'http://rubygems.org'

gem 'rails', '3.1.0'

gem 'haml'
gem 'RedCloth'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
#

group :development, :test do
  gem 'heroku'
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'database_cleaner'
end

group :production do
  gem 'therubyracer-heroku'
  gem 'pg'
end

group :test do
  gem 'cucumber-rails'
end
