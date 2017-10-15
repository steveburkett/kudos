source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.3'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'sass-rails'

gem 'will_paginate'
gem 'devise'

gem 'faker'
gem 'jquery-rails'
gem 'bootstrap-sass', '~> 2.3.2.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'rspec-rails', '~> 3.6.1'
  gem 'pry-rails', '~> 0.3.4'
  gem 'pry-byebug', '~> 3.4.1', platform: :mri
end

group :development do
  gem 'annotate', '~> 2.7.2'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.8'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'timecop'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
