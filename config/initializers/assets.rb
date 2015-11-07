precompiled = %w(home.css email.css embed.css library.css)
precompiled += %w(home.js explore.js library.js)
Rails.application.config.assets.precompile += precompiled
