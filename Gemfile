source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'bootsnap', require: false
gem 'devise'
gem 'jbuilder', '~> 2.0'
gem 'pg', '~> 0.21'
gem 'puma'
gem 'rails', '~> 6.0'
gem 'redis'

gem 'autoprefixer-rails'
gem 'font-awesome-sass', '~> 5.6.1'
gem 'sassc-rails'
gem 'simple_form'
gem 'uglifier'
gem 'webpacker'
gem 'cloudinary', '~> 1.9.1' # require: false #82120  added this to get rich text to work, testing it. the false part i mean
gem 'carrierwave', '~> 1.2'
gem 'jquery-fileupload-rails', git: 'git://github.com/ollnixon/jquery-fileupload-rails.git'
gem 'coffee-rails'
gem 'geocoder'
gem 'country_select'
gem 'country_state_select'
gem 'city-state'
gem "algoliasearch-rails"
gem 'jquery-rails'
gem 'acts_as_favoritor'
gem 'commontator'
gem 'pg_search'
gem 'flag-icons-rails'
gem 'acts_as_follower', github: 'tcocca/acts_as_follower', branch: 'master'
gem 'acts_as_votable'
gem "select2-rails"
gem 'select2_simple_form', github: 'lndl/select2_simple_form', tag: '0.7.3'
# source 'https://rails-assets.org' do
#   gem 'rails-assets-select2', '~> 4.0.0'
#   end
gem 'money-rails'
gem 'stripe'
gem 'stripe_event'
gem 'faker'
gem "mailboxer"
gem "punching_bag"
gem 'social-share-button'
gem 'serviceworker-rails'
gem 'sprockets', '~> 3.7.2'
gem 'friendly_id', '~> 5.2.4'
gem 'acts-as-taggable-on', '~> 6.0'
gem 'will_paginate', '~> 3.1.0'
# gem 'image_processing', '~> 1.2' #For active text blog to work/display right...or not.
# gem 'activestorage-cloudinary-service' #82120  added this to get rich text to work, testing it.  NVM
gem 'trix-rails', require: 'trix'





group :development do
  gem 'web-console', '>= 3.3.0'
  # gem "better_errors"
  gem "binding_of_caller"
  gem 'letter_opener'
  gem 'bullet'
  gem 'rack-mini-profiler'
  gem 'letter_opener'
end

group :development, :test do
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'dotenv-rails'
  gem 'better_errors' #Don't use with RSPEC.  Wait, why not?
  gem 'binding_of_caller' #REPL for better errors.
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
end

#I added this from app academy tutorial on 63020 for rspec testing
group :test do
  # gem 'faker'
  gem 'capybara'
  gem 'spring-commands-rspec'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'shoulda-matchers'
end
