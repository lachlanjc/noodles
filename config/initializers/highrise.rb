require 'highrise'

Highrise::Base.site = 'https://noodles.highrisehq.com'
Highrise::Base.user = ENV['HIGHRISE']
Highrise::Base.format = :xml
