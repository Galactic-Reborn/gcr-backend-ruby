source "https://rubygems.org"

ruby "3.2.2"
gem "rails", "~> 7.1.3"
gem "puma", ">= 5.0"
gem "jbuilder"
gem "eth"
gem 'cancancan'
gem 'pg'
gem 'rack-cors'
gem 'annotate'
gem 'devise-jwt', '0.11.0'
gem 'rspec-snapshot'
gem 'rack-attack'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem 'dotenv-rails', groups: [:development, :test]

gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem 'byebug', '11.1.3', platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails"
end

group :development do

end

group :test do
  gem 'database_cleaner-active_record'
  gem 'rspec_junit_formatter'
  gem 'simplecov', '0.22.0'
end
