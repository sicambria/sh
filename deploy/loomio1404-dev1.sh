#!/bin/bash
sudo echo "Setting up Loomio development environment for Ubuntu 14.04 x64"
sudo apt-get install -y wget
sudo apt-get install -y git-core 

# Add PostgreSQL repository
sudo add-apt-repository "deb https://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main"
wget --quiet -O - https://postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Add Ruby 2.3 repository
yes | sudo apt-add-repository ppa:brightbox/ruby-ng
sudo apt-get update

sudo apt-get install -y postgresql-9.4 postgresql-contrib-9.4  
sudo apt-get install -y libreadline-gplv2-dev 
sudo apt-get install -y build-essential 
sudo apt-get install -y libssl-dev libpq-dev libffi-dev libmagickwand-dev
sudo apt-get install -y nodejs npm imagemagick libssl-dev libreadline-dev zlib1g-dev
sudo apt-get install -y rbenv rake ruby2.3 ruby2.3-dev ruby-railties-4.0 libsqlite3-dev

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile

echo
echo "rbenv test"
type rbenv

git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# Update Ruby if needed:
# cd ~/.rbenv/plugins/ruby-build
# git pull

rbenv install 2.3.0
rbenv global 2.3.0
rbenv rehash

# Symlink NodeJS
sudo ln -s /usr/bin/nodejs /usr/bin/node

echo
echo "Setup your database"
echo
whoami > /tmp/whoami.log
sudo -u postgres psql -c "CREATE USER `cat /tmp/whoami.log` WITH PASSWORD '';"
sudo -u postgres psql -c "ALTER USER `cat /tmp/whoami.log` CREATEDB;"

#GRANT ALL PRIVILEGES ON  DATABASE database_name to new_user;
#ALTER DATABASE database_name owner to new_user;

echo 'There should be an Error message that the user already exists:'
echo
sudo -u postgres psql -c "CREATE USER `cat /tmp/whoami.log` WITH PASSWORD '';"

# Enable DB access:
sudo perl -pi -e 's?peer?trust?g' /etc/postgresql/9.4/main/pg_hba.conf
sudo service postgresql restart

#Alternative way:
#echo 'OR Run this command: createuser -s YOUR_USERNAME'
#echo 'Then type exit.'
#sudo -i -u postgres
#createuser -s `cat /tmp/whoami.log`
#exit

echo "CLONING LOOMIO"

mkdir ~/projects
git clone https://github.com/loomio/loomio.git ~/projects/loomio
cd ~/projects/loomio
git remote add github git@github.com:loomio/loomio.git
echo

echo "Install GEMS"
cd ~/projects/loomio
sudo gem install bundler
sudo gem install rake
bundle install

sudo npm install -g bower
sudo npm install -g gulp
npm install gulp-sass --save-dev


########################################################################
########################################################################
# IF you get an error, copy-paste and run these commands again manually:
########################################################################
########################################################################
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
echo "You should now be able to browse to your localhost Loomio: http://localhost:3000"
echo "To create a sample discussion, run: localhost:3000/development/setup_discussion"

cd ~/projects/loomio/angular
gulp dev
# If you have an issue with gulp, then run these 2 commands, then run this script again:
# cd
# rm -rf .npm

# Start server:
# rails s
