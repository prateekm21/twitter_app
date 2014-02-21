require 'resque/server'

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port)

#Resque.logger.formatter = Resque::VerboseFormatter.new