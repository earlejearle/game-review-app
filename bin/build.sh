#!/usr/bin/env bash
# exit on error
set -o errexit

# Add build commands for front end
echo "Deleting public directory"
rm -rf public
echo "Running npm install and build for client"
npm install --prefix client && npm run build --prefix client
echo "copy build to public"
cp -a client/build/. public/

echo "Starting bundle install"
bundle install
echo "Running rake db:migrate"
bundle exec rake db:migrate
echo "Running rails db:seed"
bundle exec rails db:seed