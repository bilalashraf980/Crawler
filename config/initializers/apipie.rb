Apipie.configure do |config|
  config.app_name                = "ProxyCrawlTest"
  config.copyright               = "&copy; #{Date.today.year} ProxyCrawlTest"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apidoc"
  config.languages               = ['en']
  config.default_locale          = 'en'
  config.validate                = true
  config.validate_presence       = true
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"
  config.default_version         = "Public - V 1.0"
end
