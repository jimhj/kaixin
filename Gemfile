# source 'https://rubygems.org'
source 'https://ruby.taobao.org'

gem 'rails', '4.2.1'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

# Slim for Template
gem 'slim', '~> 3.0.3'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.10'

# Sidekiq for queue
gem 'sidekiq', '~> 3.3.4'
gem 'sinatra', require: nil

# Redis
gem "hiredis", "~> 0.4.0"
gem "redis", ">= 2.2.0"

# Cache
gem 'dalli', '~> 2.7.4'

# File Upload
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'mini_magick', '~> 4.2.3'

# Pagination
gem 'will_paginate', '~> 3.0.6'

# Hanzi to Pinyin
gem 'chinese_pinyin', '~> 0.7.0'

# Collection Render Cache
gem 'multi_fetch_fragments', '~> 0.0.17'

group :development do
  # Deployment
  gem 'capistrano', '~> 3.4.0'
  gem 'capistrano-rvm'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  # gem "capistrano-resque", "~> 0.2.2"
end

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'thin'
end

