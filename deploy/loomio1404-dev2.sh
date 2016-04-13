#!/bin/bash
cd ~/projects/loomio
cp config/database.example.yml config/database.yml
bundle install
bundle exec rake db:setup

sudo npm install -g bower
sudo npm install -g gulp

rails s
echo "You should now be able to browse to your localhost Loomio: http://localhost:3000"
