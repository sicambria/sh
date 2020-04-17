#!/bin/bash

echo "This script offloads non-system files (/opt, flatpak, snaps) to another drive"

TARGET_DRIVE=$1

if [[ -z $1 ]] ; then
  echo "Usage: sudo ./offload.sh /media/USERNAME/DRIVENAME"
  echo "Specified drive path must be without slash at the end!"
  exit 0
fi

echo
echo "Move /opt, flatpak and snaps to drive:"
echo "$1"
echo "Proceed? Press ENTER to continue or CTRL-C to exit."

read

mv /opt $TARGET_DRIVE
sudo ln -s $TARGET_DRIVE/ /


sudo mv /var/lib/flatpak $TARGET_DRIVE
sudo ln -s $TARGET_DRIVE/flatpak/ /var/lib/flatpak/


sudo mv /var/lib/snapd/snaps $TARGET_DRIVE
sudo ln -s $TARGET_DRIVE/snaps/ /var/lib/snapd/snaps
