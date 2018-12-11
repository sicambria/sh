#!/bin/bash
echo "Purge old kernels? Press CTRL-C to STOP or ENTER to continue."
read
echo "START DRY RUN"
dpkg -l linux-* | awk '/^ii/{ print $2}' | grep -v -e `uname -r | cut -f1,2 -d"-"` | grep -e [0-9] | grep -E "(image|headers)" | xargs sudo dpkg --remove --dry-run
echo "All is OK? Press CTRL-C to STOP or ENTER to remove the kernels listed above."
read
dpkg -l linux-* | awk '/^ii/{ print $2}' | grep -v -e `uname -r | cut -f1,2 -d"-"` | grep -e [0-9] | grep -E "(image|headers)" | xargs sudo dpkg --remove

# Thanks to http://tuxtweaks.com/2010/10/remove-old-kernels-in-ubuntu-with-one-command/
