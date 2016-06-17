#!/bin/bash
sudo echo "Setting up Loomio development environment for Ubuntu 16.04 x64"
cd
sudo apt-get install -y wget
sudo apt-get install -y git-core 

# Add PostgreSQL repository
sudo add-apt-repository "deb https://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main"
wget --quiet -O - https://postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

sudo apt-get update

sudo apt-get install -y postgresql-9.4 postgresql-contrib-9.4  
sudo apt-get install -y libreadline-gplv2-dev 
sudo apt-get install -y build-essential 
sudo apt-get install -y libssl-dev libpq-dev libffi-dev libmagickwand-dev
sudo apt-get install -y imagemagick libssl-dev libreadline-dev zlib1g-dev
sudo apt-get install -y rake libsqlite3-dev

echo "Symlink NodeJS"
sudo ln -s /usr/bin/nodejs /usr/bin/node

echo
echo "Setup your database"
echo
echo "Enable passwordless local DB access"
sudo perl -pi -e 's?peer?trust?g' /etc/postgresql/9.4/main/pg_hba.conf
sudo service postgresql restart
echo
whoami > /tmp/whoami.log
sudo -u postgres psql -c "CREATE USER `cat /tmp/whoami.log` WITH PASSWORD '';"
sudo -u postgres psql -c "ALTER USER `cat /tmp/whoami.log` CREATEDB;"

#GRANT ALL PRIVILEGES ON  DATABASE database_name to new_user;
#ALTER DATABASE database_name owner to new_user;

echo 'There should be an Error message that the user already exists:'
echo
sudo -u postgres psql -c "CREATE USER `cat /tmp/whoami.log` WITH PASSWORD '';"


#Alternative way:
#echo 'OR Run this command: createuser -s YOUR_USERNAME'
#echo 'Then type exit.'
#sudo -i -u postgres
#createuser -s `cat /tmp/whoami.log`
#exit
