#!/bin/sh

#+SYSTEM
sudo apt-get install gmountiso p7zip rar lame xfburn
sudo apt-get install krusader kdiff3 krename
sudo apt-get install gnome-system-tools bleachbit gparted

# Run Windows applications - Office 2003/2007/2010, Total Commander, Photoshop, games, etc...
sudo add-apt-repository ppa:ubuntu-wine/ppa
sudo apt-get install playonlinux winetricks wine1.7

# HDD
sudo apt-get install preload shred srm

# HU
sudo apt-get install language-pack-hu language-pack-gnome-hu language-pack-hu-base language-pack-gnome-hu-base 

#+OFFICE
sudo apt-get install libreoffice-presentation-minimizer libreoffice-l10n-hu aspell-hu hunspell-hu aspell-en hunspell-en-us

#+MEDIA
sudo apt-get install vlc phatch nautilus-image-converter audacity picard puddletag

# Skype telepítése
#Ubuntu - enable "partner" repository
sudo sed -i "/^# deb .*partner/ s/^# //" /etc/apt/sources.list
sudo apt-get update
sudo apt-get install skype

#  Skype honlap - Website:
#http://www.skype.com/hu/download-skype/skype-for-linux/downloading/?type=ubuntu64

#+Google Chrome
sudo deb http://dl.google.com/linux/deb/ stable non-free main
sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt-get update
sudo apt-get install google-chrome-stable

# Install Chromium + default incognito mode
sudo apt-get install chromium-browser
sudo perl -pi -e 's?Exec=chromium-browser?Exec=chromium-browser --incognito?g' /usr/share/applications/chromium-browser.desktop


# Gnomebaker CD/DVD író program - GnomeBaker CD/DVD writer
sudo add-apt-repository ppa:gnomebaker/stable
sudo apt-get update
sudo apt-get install gnomebaker

# Nem szükséges programok eltávolítása -  Remove unneeded apps - OPTIONAL
sudo apt-get purge brasero
sudo apt-get purge thunderbird

# Apport letiltása - megszűnnek a bosszantó rendszerösszeomlás-jelentések
# Disable apport - remove annoying system crash messages
sudo perl -pi -e 's/enabled=1/enabled=0/g' /etc/default/apport

# Swap only after 90% RAM is full
echo "vm.swappiness = 10" | sudo tee -a /etc/sysctl.conf

# Szoftver tárolók könnyű hozzáadása
# Add repositories easily:
sudo apt-get install python-software-properties

# e.g. install MUMBLE VoIP client:
sudo add-apt-repository ppa:mumble/release
sudo apt-get update
sudo apt-get install mumble

# SWF fájlok megnyitása böngészőben - Play SWF files in browser
sudo perl -pi -e 's?<mime-type type="application/vnd.adobe.flash.movie">?<mime-type type="application/x-shockwave-flash">?g' /usr/share/mime/packages/freedesktop.org.xml
sudo update-mime-database /usr/share/mime


#Installing MATE in Ubuntu 14.04 LTS

sudo apt-add-repository ppa:ubuntu-mate-dev/ppa
sudo apt-add-repository ppa:ubuntu-mate-dev/trusty-mate
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install --no-install-recommends ubuntu-mate-core ubuntu-mate-desktop

# TEAMVIEWER - Távsegítség program telepítése - REMOTE HELP
cd
cd Letöltések
cd Downloads
wget http://download.teamviewer.com/download/teamviewer_i386.deb
sudo apt-get install gdebi
sudo gdebi teamviewer_i386.deb
