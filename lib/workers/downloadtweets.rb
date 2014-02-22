require 'tweetstream'
require 'fiber'
require 'eventmachine'

module Workers
  module DownloadTweets

    class Download
      @@counter = 0
      #API KEYS FROM TWITTER
      API_KEY        = 'lD8kpCxDOyT4BCKu5ZwlYA'
      API_SECRET     = '6MZw4XUiAD0k2RYJAOUIm2Dd0EJeTgtKYj20jeXoaSw'
      ACCESS_TOKEN   = '27935905-idpW3KfLyGFN8VFzTh0Ki9YA6wcg0NtFN7I53iDHx'
      ACCESS_SECRET  = 'caf7UGzmlNu4VNyYuTo9Z8hUosfeZAVaK9ETC7N3HH5fe'

      def self.start
        TweetStream.configure do |config|
          config.consumer_key       = API_KEY
          config.consumer_secret    = API_SECRET
          config.oauth_token        = ACCESS_TOKEN
          config.oauth_token_secret = ACCESS_SECRET
          config.auth_method        = :oauth
        end

        EventMachine.threadpool_size = 30

        EventMachine.run do
          client = TweetStream::Client.new

          def self.async_write(status)
            EventMachine.defer do
              Fiber.new do
                location = status.geo[:coordinates]            rescue []
                _htag     = status.attrs[:entities][:hashtags] rescue []
                #get only tags names
                htag     = _htag.map {|e| e[:text]} unless _htag.empty?
                l        = location.map {|ech| ech.to_f} unless location.blank?

                obj = {
                    :location   => l,
                    :username   => status.user.screen_name,
                    :tweet      => status.text,
                    :hash_tags  => htag.nil? ? []: htag ,
                    :tweet_date => status.created_at
                }
                puts "\n===="
                puts obj
                #save to DB
                Tweet.create(obj)
                puts "Counter: #{@@counter}" if @@counter%500 == 0
                EventMachine.stop if @@counter == 500000
              end.resume
            end
          end

          client.locations("-180,-90,180,90") do |status|
            async_write(status)
            @@counter = @@counter + 1
          end

        end #em
      end #start
    end #class
  end #module
end #module