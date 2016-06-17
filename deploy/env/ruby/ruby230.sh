#!/bin/bash
echo "Turn ON _Run command as a login shell_ in Terminal/Edit/Profile preferences/[Title and ]Command"
echo
read -p "Have you done this step opened a new terminal? <y/N> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    \curl -L https://get.rvm.io | bash -s stable --ruby
    source /home/gaspar/.rvm/scripts/rvm
    rvm get stable --autolibs=enable
    rvm install ruby
    rvm --default use ruby-2.3.0
    echo "DONE! Exit this Terminal window and continue in a new one!"
else
    echo "Make sure you open a *new Terminal* after you have enabled _Run command as a login shell_."
  exit 0
fi
