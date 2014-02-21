require 'workers/downloadtweets'

module Workers
  module Fetch

    class DownloadTweets
      @queue = :download_tweet

      def self.perform
        Workers::DownloadTweets::Download.start
      end
    end #class

  end #FetchTweets
end #Workers