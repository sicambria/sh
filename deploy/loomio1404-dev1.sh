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

echo
echo "CLONING LOOMIO"

mkdir ~/projects
git clone https://github.com/loomio/loomio.git ~/projects/loomio
cd ~/projects/loomio
git remote add github git@github.com:loomio/loomio.git

echo
echo "GEMS"
sudo gem install bundler
sudo gem install rake
bundle install
rbenv rehash
rake bootstrap

echo
echo "Setup your database"
echo
whoami > /tmp/whoami.log
sudo -i -u postgres
createuser -s `cat /tmp/whoami.log`
echo "CONTINUE with loomio1404-dev2.sh IF database user has been sucessfully created."
exit
