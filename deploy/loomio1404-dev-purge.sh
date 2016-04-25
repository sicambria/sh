#!/bin/bash
echo "Purge FULL Loomio/Ruby/NPM development environment (Ubuntu 14.04 x64)"
read -p "Are you sure? (Y/N)" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  sudo apt-get purge -y git-core postgresql-9.4 postgresql-contrib-9.4 build-essential \
                     libssl-dev libpq-dev libffi-dev libmagickwand-dev \
                     libreadline-gplv2-dev nodejs imagemagick
  sudo apt-get purge -y libssl-dev libreadline-dev zlib1g-dev
  sudo apt-get purge -y rbenv rake libsqlite3-dev
  sudo apt-get purge -y ruby2.3 ruby2.3-dev ruby-railties-4.0
  
  sudo apt-get --purge remove postgresql\* -y
  sudo rm -rf /etc/postgresql/
  sudo rm -rf /etc/postgresql-common/
  sudo rm -rf /var/lib/postgresql/
  cd
  sudo rm -rf projects
  sudo rm -rf loomio-deploy
  sudo rm -rf .rbenv
  sudo rm -rf .gem
  sudo rm -rf .npm
  sudo rm -rf .bundler
  sudo userdel -r postgres
  sudo groupdel postgres
  sudo apt-get -y autoremove
  exit 0
fi

echo "Exiting, no changes have been made."

