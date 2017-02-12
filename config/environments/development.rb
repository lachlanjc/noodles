Rails.application.configure do

  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local = true
  config.action_controller.perform_caching = true

  config.action_mailer.raise_delivery_errors = false

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load
  config.active_record.raise_in_transactional_callbacks = true

  config.assets.debug = true
  config.assets.raise_runtime_errors = true

  config.action_view.raise_on_missing_translations = true

  Rails.application.routes.default_url_options[:host] = 'localhost:3000'

  # Paperclip Settings
  config.paperclip_defaults = {
    storage: :s3,
    bucket: 'noodles-assets-dev',
    s3_credentials: {
      access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }
  }

  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { host: 'localhost:9292' }
  config.action_mailer.delivery_method = :mandrill

  config.react.variant = :development

end
