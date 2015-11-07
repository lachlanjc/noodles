asset_names = %w(email.css embed.css home.css library.css)
asset_names += %w(explore.js library.js)
Rails.application.config.assets.precompile += asset_names
