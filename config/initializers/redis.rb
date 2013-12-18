rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
rails_env = ENV['RAILS_ENV'] || 'development'

# $resque_config = YAML.load_file(rails_root + '/config/resque.yml')
# uri = URI.parse($resque_config[rails_env])
Resque.redis = Redis.connect :url => ENV["OPENREDIS_URL"]