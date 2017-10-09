source 'https://rubygems.org'
ruby '2.4.1'

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
# gem 'devise_marketable'
gem 'coffee-rails'
gem 'cohort_me'
gem 'hangry'
gem 'html_to_plain_text'
gem 'ingreedy'
gem 'intercom-rails'
gem 'jquery-rails'
gem 'marginalia'
gem 'mechanize'
gem 'paperclip'
gem 'pg'
gem 'prawnto_2', require: 'prawnto'
gem 'puma'
gem 'rails', '5.1.4'
gem 'rails-controller-testing'
gem 'rake'
gem 'redcarpet'
gem 'safely_block'
gem 'sass-rails'
gem 'skylight'
gem 'stripe'
gem 'therubyracer'
gem 'turbolinks'
gem 'uglifier'
gem 'webpacker'
gem 'webpacker-react'
gem 'wombat'

source 'https://rails-assets.org' do
  gem 'rails-assets-clipboard'
  gem 'rails-assets-imagesloaded'
  gem 'rails-assets-lodash'
  gem 'rails-assets-masonry'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'foreman'
  # gem 'tracer_bullets'
  gem 'web-console'
end

group :production do
  gem 'rails_12factor'
end
