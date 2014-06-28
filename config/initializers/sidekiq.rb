Sidekiq.configure_server do |config|
  config.redis = { :url => ENV['REDISTOGO_URL'], :namespace => 'wine-sales' }
end

Sidekiq.configure_client do |config|
  config.redis = { :url => ENV['REDISTOGO_URL'], :namespace => 'wine-sales' }
end
