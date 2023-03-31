#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"


# # If the database exists, migrate. Otherwise setup (create and migrate)

echo "Running database migrations..."

undle exec rails db:migrate 2>/dev/null || bundle exec rails db:create db:migrate

bundle exec rails db:seed

echo "Finished running database migrations."


# # Remove a potentially pre-existing server.pid for Rails.

echo "Deleting server.pid file..."

rm -f /tmp/pids/server.pid


# # Start the server.

echo "Starting rails server..."

bundle exec rails server