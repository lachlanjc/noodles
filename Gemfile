source 'https://rubygems.org'
ruby '2.7.2'

git_source(:github) do |repo|
  repo = "#{repo}/#{repo}" unless repo.include?("/")
  "https://github.com/#{repo}.git"
end

gem 'dotenv-rails'

gem 'actionpack-page_caching'
gem 'actionpack-action_caching'
gem 'active_model_serializers'
gem 'autoprefixer-rails'
gem 'aws-sdk', '~> 2'
gem 'aws-sdk-rails'
gem 'delayed_job_active_record'
gem 'devise'
gem 'coffee-rails'
gem 'hangry'
gem 'html_to_plain_text'
gem 'ingreedy'
gem 'intercom-rails'
gem 'jquery-rails'
gem 'mechanize'
gem 'mini_racer'
gem 'paperclip', '5.2.1'
gem 'pg', '~> 0.18'
gem 'prawnto_2', require: 'prawnto'
gem 'puma', '~> 4.3'
gem 'rails', '5.1.4'
gem 'rails-controller-testing'
gem 'rake'
gem 'redcarpet'
gem 'safely_block'
gem 'sassc-rails'
gem 'stripe'
gem 'turbolinks'
gem 'twilio-ruby'
gem 'uglifier'
gem 'webpacker', '4.0.0.rc.2'
gem 'webpacker-react'

source 'https://rails-assets.org' do
  gem 'rails-assets-clipboard', '1.7.1'
  gem 'rails-assets-imagesloaded'
  gem 'rails-assets-lodash'
  gem 'rails-assets-masonry'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'foreman'
  gem 'web-console'
end

group :production do
  gem 'rails_12factor'
  gem 'skylight'
end
