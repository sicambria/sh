#!/bin/bash

# Cpulimit - How to Limit The CPU Usage of Any Process in Linux
# Source: https://www.maketecheasier.com/limit-cpu-usage-of-any-process-in-linux/

if [[ -z $1 ]] ; then
  echo "Usage: ./cpulimiter.sh install | uninstall"
  exit 0
fi

if [[ $1 == "install" ]] ; then
  sudo apt-get install cpulimit gawk
  cd
  mkdir cpulimit
  cd cpulimit
  wget https://raw.githubusercontent.com/sicambria/sh/master/system/cpulimit/cpulimit
  wget https://raw.githubusercontent.com/sicambria/sh/master/system/cpulimit/cpulimit_daemon.sh

  # Limit any process to use maximum 80% of a single CPU core
  # Use 1 core fully = 100%
  # Use 2 core fully = 200%
  # etc.
  sudo perl -pi -e 's?CPU_LIMIT=20?CPU_LIMIT=80?g' cpulimit_daemon.sh


  sudo cp ~/cpulimit/cpulimit_daemon.sh /usr/bin
  sudo chmod 700 /usr/bin/cpulimit_daemon.sh

  sudo cp ~/cpulimit/cpulimit /etc/init.d/
  sudo chown root:root /etc/init.d/cpulimit
  sudo chmod +x /etc/init.d/cpulimit
  sudo update-rc.d cpulimit defaults

  sudo service cpulimit start
  exit 0
fi


if [[ $1 == "uninstall" ]] ; then
  sudo service cpulimit stop  # Stop cpulimit daemon and all cpulimited processes
  sudo update-rc.d -f cpulimit remove    # Remove symbolic links
  sudo rm /etc/init.d/cpulimit           # Delete cpulimit boot-up script
  sudo rm /usr/bin/cpulimit_daemon.sh    # Delete cpulimit daemon script
  sudo apt-get remove cpulimit
  exit 0
fi
