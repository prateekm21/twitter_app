require 'resque/server'

uri          = URI.parse(ENV["REDISTOGO_URL"])

if Rails.env == 'production'
  Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
else
  Resque.redis = Redis.new(:host => uri.host, :port => uri.port)
end


#Resque.logger.formatter = Resque::VerboseFormatter.new