source 'https://rubygems.org'

# git_source(:github) do |repo_name|
#   repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
#   "https://github.com/#{repo_name}.git"
# end

gem 'sassc'

gem 'rails', '5.1.3'

gem 'mongoid', '6.1.0'

gem 'bootstrap-sass'

gem 'jquery-ui-rails'

gem 'devise', '4.7.1'
# gem 'kaminari'

# gem 'carrierwave'
# gem 'fog'
gem 'aws-sdk', '~> 2'

gem 'mini_magick'

gem 'data_uri'

gem 'figaro'

# gem 'tesseract-ocr', '~> 0.1.8'

# gem 'fog'
gem 'faker'

gem 'whenever', :require => false

# gem 'farm_ruby', git: 'https://github.com/jessethebuilder/farm_ruby'

gem 'farm_shed', git: 'https://github.com/jessethebuilder/farm_shed', branch: 'lite'
# gem 'farm_shed', path: '/var/www/my_gems/farm_shed', branch: 'lite'

gem 'farm_devise_views', git: 'https://github.com/jessethebuilder/farm_devise_views'

# gem 'farm_scrape', git: 'https://github.com/jessethebuilder/farm_scrape.git'

gem 'rtesseract'
# gem 'tesseract-ocr'

group :test, :development do
  # gem 'faker'
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
  #gem 'webrat'
  gem 'poltergeist'
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'

gem 'puma'

gem 'uglifier', '3.2.0'

gem 'jquery-rails'

gem 'turbolinks', '~> 5'

gem 'jbuilder', '~> 2.5'

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

ruby '2.5.6'
