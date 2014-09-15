Rails.application.configure do

  config.action_controller.asset_host = "d1abhwwnwy089u.cloudfront.net"

  config.cache_classes = true

  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_assets = false

  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :sass

  config.assets.compile = false

  config.assets.digest = true

  config.assets.version = '1.0'

  config.log_level = :info

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new

  config.active_record.dump_schema_after_migration = false

  # S3 Paperclip Settings
  config.paperclip_defaults = {
  :storage => :s3,
  :s3_credentials => {
    :bucket => ENV['noodles-assets'],
    :access_key_id => ENV['AKIAJPPNZ6FCBWYXNQMA'],
    :secret_access_key => ENV['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']
  }
}
end
