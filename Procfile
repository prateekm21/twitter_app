# Usage:
# foreman start

web:          bundle exec unicorn -p $PORT -E $RACK_ENV
backgroud:    bundle exec rake resque:work QUEUE=download_tweet TERM_CHILD=1
