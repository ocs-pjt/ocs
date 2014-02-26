source 'https://rubygems.org'

gem 'rails', '4.1.0.rc1'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'

# Gem to handle complex json responses
gem 'jbuilder', '~> 2.0'

# Gem for use of twitter bootstrap
gem 'bootstrap-sass', '~> 3.0'

# Gem to handle authorizations and permissions
gem 'cancan'

# Gem for the authentication
gem 'devise', github: 'plataformatec/devise'
gem 'haml-rails'

# Gem to handle the postgresql driver
gem 'pg', platforms: [:mri_19, :mri_20, :mri_21, :rbx]
gem 'activerecord-jdbcpostgresql-adapter', platforms: [:jruby]

gem 'rolify'

# Gem to handle form in a simple way :)
gem 'simple_form', '>= 3.0.0.rc'

# Gem to import files / documents / pictures etc...
gem 'carrierwave'

# Management and monitoring of the production servers 
gem 'newrelic_rpm'

# Gem to process requests in background
gem 'sidekiq'

# Gem to ask the status of a job for sidekiq
gem 'sidekiq-status'

gem 'activeresource', require: 'active_resource'
gem 'activeresource-persistent', require: 'active_resource/persistent'

# Gem to handle omniauth authentication
gem 'omniauth'

# Gem to handle facebook authentication
gem 'omniauth-facebook'

# Gem to handle google authentication
gem 'omniauth-google-oauth2'

# Handle environment variables
gem 'figaro', github: 'laserlemon/figaro'

# Rails asset-pipeline gem to simply add/remove nested objects
gem 'cocoon'

# Gem for geolocation
gem 'geocoder'

# Rails asset-pipeline gem to provide underscore.js
gem 'underscore-rails'

# Gem to display maps 
gem 'gmaps4rails'

# Handle pagination
gem 'will_paginate'

# Handle simple search on facets
gem 'facetious', github:  'lothar59/facetious'

# datepicker for twitter bootstrap
gem 'bootstrap-datepicker-rails'

# Ruby XZ compression tool
gem 'ruby-xz'

# Add vector maps with regions
gem 'jvectormap-rails', github: 'lothar59/jvectormap-rails'

# Tasks Scheduler
gem 'whenever', require: false

group :assets do
  gem 'therubyracer', platform: :ruby
end

group :development do
  # Profiler ruby
  gem 'ruby-prof', platforms: [:mri_19, :mri_20, :mri_21, :rbx]

  # Gem to display errors when occuring in development mode
  gem 'better_errors', '>= 1.1.0'
  gem 'binding_of_caller', platforms: [:mri_19, :mri_20, :mri_21, :rbx]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'html2haml', platforms: [:mri_19, :mri_20, :mri_21, :rbx]
  gem 'hub', require: nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false

  # Gem to use for deployment
  gem 'capistrano', '~> 3.0'
  gem "rvm1-capistrano3", "~> 1.0", require: false
  gem 'highline'

  # Gem to display and warn for eventual security holes
  gem 'brakeman', require: false

  # Gem to populate quickly the database with basic demo data
  gem 'populator', require: false

  # Thin web-server
  gem 'thin', platforms: [:mri_19, :mri_20, :mri_21, :rbx]
  
  # Pry debugger
  gem 'pry', '~> 0.9'
  gem 'pry-remote'
  gem 'pry-nav'

  # Debugger
  gem 'debugger2', platforms: [:mri_19, :mri_20, :mri_21, :rbx]

  # Print objects awesomly
  gem 'awesome_print'
end

group :development, :test do
  # Gem to use for tests to handle factories 
  gem 'factory_girl_rails'

  # Use of rspec for the test environment
  gem 'rspec-rails'

  # Gem to populate factories with random but human-readable data
  gem 'ffaker'

  # For the coverage badge
  gem 'coveralls', require: false
end

#group :production do
  # Puma webserver
  gem 'puma'
#end

group :test do
  gem 'capybara'
  gem 'database_cleaner', '~> 1.2.0'
  gem 'email_spec'

  # Gem that display
  gem 'simplecov', require: false
end

platforms :rbx do
  gem 'racc'
  gem 'rubysl', '~> 2.0'
  gem 'psych'
end