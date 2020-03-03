source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'sprockets', '3.7.1'

gem 'sass-rails'

# gem 'mongoid', '6.1.0'
gem 'mongo', '2.8'
gem 'mongoid', '~> 7.0.5'


gem 'bootstrap-sass'
gem 'jquery-ui-rails'

gem 'rails', '5.1.3'
# , '3.2.0'

gem 'jquery-rails'

gem 'turbolinks', '~> 5'

gem 'uglifier'

gem 'jbuilder', '~> 2.5'

gem 'devise', '4.7.1'

gem 'sidekiq'

gem 'aws-sdk', '~> 2'

gem 'mini_magick'

gem 'data_uri'

gem 'figaro'

gem 'faker'

gem 'whenever', :require => false

# gem 'farm_shed', git: 'https://github.com/jessethebuilder/farm_shed', branch: 'lite'
# gem 'farm_shed', path: '/var/www/my_gems/farm_shed', branch: 'lite'

# gem 'farm_devise_views', git: 'https://github.com/jessethebuilder/farm_devise_views'
# gem 'farm_scrape', git: 'https://github.com/jessethebuilder/farm_scrape.git'

gem 'rtesseract'

 # gem 'wkhtmltopdf-heroku', '2.12.5.0'

group :test, :development do
  gem 'rspec-rails'
  gem 'mongoid-rspec'
  gem 'database_cleaner'
  gem 'timecop'
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'selenium-webdriver'
  gem 'shoulda'
  gem 'launchy', '~> 2.3.0'
  gem 'poltergeist'
end

gem 'puma'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'rails_12factor', group: :production

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

ruby '2.5.7'
