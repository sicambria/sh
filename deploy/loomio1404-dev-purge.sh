#!/bin/bash

sudo echo "Purge Loomio development environment - Ubuntu 14.04 x64"
cd
sudo apt-get purge -y git-core postgresql-9.4 postgresql-contrib-9.4 build-essential \
                       libssl-dev libpq-dev libffi-dev libmagickwand-dev \
                       libreadline-gplv2-dev nodejs imagemagick
sudo apt-get purge -y libssl-dev libreadline-dev zlib1g-dev npm
sudo apt-get purge -y rbenv rake libsqlite3-dev ruby2.3 ruby2.3-dev ruby-railties-4.0
sudo apt-get --purge remove postgresql\* -y
sudo rm -rf /etc/postgresql/
sudo rm -rf /etc/postgresql-common/
sudo rm -rf /var/lib/postgresql/
cd
sudo rm -rf projects
sudo rm -rf loomio-deploy
sudo rm -rf .rbenv
sudo userdel -r postgres
sudo groupdel postgres
