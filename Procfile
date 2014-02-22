# Usage:
# foreman start

#web:    bundle exec unicorn -p $PORT -E $RACK_ENV
web:     bundle exec rails s -P $PORT
resque:  env TERM_CHILD=1 QUEUE=download_tweet bundle exec rake resque:work
