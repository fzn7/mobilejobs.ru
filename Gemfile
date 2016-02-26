source 'https://rubygems.org'

#gem 'bugsnag'
gem 'figaro'
gem 'jquery-rails'
gem 'kaminari'
gem 'responders', '~> 2.0'
#gem 'pg'
#gem 'puma', require: false
gem 'rails'
gem 'redcarpet'
gem 'therubyracer', :platform => :ruby
gem 'uglifier'
gem 'sqlite3'
gem 'nokogiri', "=1.6.7.rc2"
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]
gem 'feedjira'
gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'
gem 'whenever'

#Rails admin gems ------>
gem 'rails_admin', github: 'sferik/rails_admin'
#<------------------------

group :production do
  gem 'newrelic_rpm'
end

group :development, :test do
  gem 'rspec-rails'
end

group :development do
  gem 'foreman', require: false
  gem 'letter_opener'
  gem 'capistrano', require: false
  gem 'capistrano-ext'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano-passenger'
end

group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
end
