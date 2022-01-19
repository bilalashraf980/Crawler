Sidekiq::Extensions.enable_delay!

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{ENV['REDIS_SERVER_HOST']}:#{ENV['REDIS_SERVER_PORT']}/#{ENV['REDIS_SERVER_DB_SYSTEM']}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{ENV['REDIS_SERVER_HOST']}:#{ENV['REDIS_SERVER_PORT']}/#{ENV['REDIS_SERVER_DB_SYSTEM']}" }
end

require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ["proxy", "proxy_crawl12"]
end