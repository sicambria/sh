#!/bin/bash
echo "Password:"
read password
echo $password | sudo -S add-apt-repository "deb https://cli-assets.heroku.com/branches/stable/apt ./"
echo $password | sudo -S apt install curl
curl -L https://cli-assets.heroku.com/apt/release.key | sudo apt-key add -
echo $password | sudo -S apt-get update
echo $password | sudo -S apt-get install heroku
echo $password | sudo -S apt-get update
echo $password | sudo -S apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs
echo $password | sudo -S apt-get install libgmp3-dev
echo $password | sudo -S apt-get install -y postgresql postgresql-server-dev-9.5
git clone https://github.com/rbenv/ruby-build.git
cd ruby-build/
echo $password | sudo -S ./install.sh
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
rbenv install 2.4.0
rbenv global 2.4.0
ruby -v
gem install bundler
rbenv rehash
git clone https://github.com/cobudget/cobudget-api
cd cobudget-api
bundle install
whoami > /tmp/whoami.log
echo $password | sudo -S -u postgres psql -c "CREATE USER `cat /tmp/whoami.log` WITH PASSWORD '';"
echo $password | sudo -S -u postgres psql -c "ALTER USER `cat /tmp/whoami.log` CREATEDB;"
gem install mailcatcher
mailcatcher
cp config/database.example.yml config/database.yml
bundle exec rake db:setup
bin/delayed_job start
bundle exec rails s
bundle exec rake jobs:work 
