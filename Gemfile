source 'https://rubygems.org'

gem 'bugsnag'
gem 'figaro'
gem 'foreman', require: false
gem 'jquery-rails'
gem 'kaminari'
gem 'responders', '~> 2.0'
#gem 'pg'
#gem 'puma', require: false
gem 'rails'
gem 'redcarpet'
gem 'sprockets-rails', require: 'sprockets/railtie'
gem 'therubyracer', :platform => :ruby
gem 'uglifier'
gem 'sqlite3', '1.3.11.pr159'
gem 'nokogiri', "=1.6.7.rc2"
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]
gem 'feedjira'

#Active admin gems ------>
gem 'activeadmin', github: 'activeadmin'
gem 'devise'
gem 'cancan' # or cancancan
gem 'draper'
gem 'pundit'
#<------------------------

group :production do
  gem 'newrelic_rpm'
end

group :development, :test do
  gem 'rspec-rails'
end

group :development do
  gem 'letter_opener'
  gem 'mina', require: false
end

group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
end
