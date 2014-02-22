def clean_db
  puts "Cleaning TEST DB"
  DatabaseCleaner.clean
end

def prep_db tweet_sample
  puts "Preparing TEST DB"
  tweet_sample.each{|e| Tweet.create(e)}
end