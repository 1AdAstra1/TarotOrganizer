source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

group :production do
  gem 'pg'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
  gem 'therubyracer'
end



# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development, :test do
  gem 'sqlite3'
  gem "cucumber-rails"
  gem "cucumber-rails-training-wheels"
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem "database_cleaner"
  gem "capybara"
  gem "rspec-rails", ">= 2.0.1"
  gem 'factory_girl_rails'
  gem 'simplecov', :require => false
end

gem "haml", ">= 3.0.0"
gem "haml-rails"
gem "jquery-rails"


gem "babelphish"
gem "uploader"