# Usage:
# foreman start

web:     bundle exec unicorn -p $PORT -E $RACK_ENV
resque:  env TERM_CHILD=1 QUEUE=download_tweet bundle exec rake resque:work
