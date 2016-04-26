#!/bin/bash
echo "PART 2 - Setting up Loomio development environment for Ubuntu 14.04 x64"

cd ~/projects/loomio
bundle install
cp config/database.example.yml config/database.yml
bundle exec rake db:setup

sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE loomio_development to `cat /tmp/whoami.log` ;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE loomio_test to `cat /tmp/whoami.log` ;"
sudo su postgres -c "psql loomio_development -c 'CREATE EXTENSION hstore;'"
sudo su postgres -c "psql loomio_test -c 'CREATE EXTENSION hstore;'"

bundle exec rake db:setup
bundle exec rake bootstrap > log_rake_bootstrap.log
grep 'Created user with email' log_rake_bootstrap.log > password.txt

echo "LOOMIO LOGIN:"
cat password.txt

echo
echo "localhost address for Loomio: http://localhost:3000"
echo "To create a sample discussion, run: localhost:3000/development/setup_discussion"

cd ~/projects/loomio/angular
gulp dev

# If you have an issue with gulp, then run these 2 commands, then run this script again:
# cd
# rm -rf .npm

# Start server:
# rails s
