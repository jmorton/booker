#!/bin/sh
# https://stackoverflow.com/a/38732187/1935918

set -e

if [ -f /booker/tmp/pids/server.pid ]; then
  rm /booker/tmp/pids/server.pid
fi

bundle exec rake db:create
bundle exec rake db:migrate || bundle exec rake db:setup
exec bundle exec "$@"
