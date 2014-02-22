# Usage:
# foreman start

web:    bundle exec unicorn -p $PORT -E $RACK_ENV
resque:  env TERM_CHILD=1 RESQUE_TERM_TIMEOUT=7 QUEUE=* bundle exec rake resque:work
