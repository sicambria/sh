#!/bin/bash
sudo echo "Setup Loomio"
echo "---------------------"
echo "CLONING LOOMIO"

mkdir ~/projects
git clone https://github.com/loomio/loomio.git ~/projects/loomio
cd ~/projects/loomio
git remote add upstream git@github.com:loomio/loomio.git
echo

echo "---------------------"
echo "Install GEMS"
cd ~/projects/loomio
gem install bundler
gem install rake
bundle update
bundle install

npm install -g gulp
npm install -g gulp-sass --save-dev

cd ~/projects/loomio
#bundle install
cp config/database.example.yml config/database.yml
bundle exec rake db:setup

sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE loomio_development to `cat /tmp/whoami.log` ;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE loomio_test to `cat /tmp/whoami.log` ;"
sudo su postgres -c "psql loomio_development -c 'CREATE EXTENSION hstore;'"
sudo su postgres -c "psql loomio_test -c 'CREATE EXTENSION hstore;'"

bundle exec rake db:setup
bundle exec rake bootstrap > log_rake_bootstrap.log
grep 'Created user with email' log_rake_bootstrap.log > password.txt

echo
echo "localhost address for Loomio: http://localhost:3000"
echo "To create a sample discussion, run: localhost:3000/development/setup_discussion"

echo "---------------------"
echo "LOOMIO LOGIN:"
echo "---------------------"
cat password.txt
echo "---------------------"


read -p "Would you like to see a sample group/thread in Loomio? <y/N> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
    echo "Creating sample group and thread."
    firefox localhost:3000/development/setup_discussion
else
    echo "Ok, no action."
fi


echo "Open a new Terminal, go to ~/projects/loomio/ folder and run: rails s"
echo
echo "Gulp is a task/build runner for development."
echo "It allows you to do a lot of stuff within your development workflow."
echo " You can compile sass files, uglify and compress js files and much more."
echo " So we run _gulp dev_ during development."

cd ~/projects/loomio/angular
gulp dev

# If you have an issue with gulp, then run these 2 commands, then run this script again:
# cd
# rm -rf .npm

# Start server:
# rails s
