rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
rails_env = ENV['RAILS_ENV'] || 'development'

$resque_redis_url = uris_per_environment[rails_env]
Resque.redis = $resque_redis_url
