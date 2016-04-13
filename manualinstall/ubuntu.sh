#!/bin/sh

echo "Install common Linux applications to Ubuntu"
cd
cd Letöltések
cd Downloads

#+SYSTEM
sudo apt-get install -y gmountiso p7zip rar lame xfburn
sudo apt-get install -y krusader kdiff3 krename
sudo apt-get install -y gnome-system-tools bleachbit gparted

# HDD
sudo apt-get install -y preload shred srm

# HU
sudo apt-get install -y language-pack-hu language-pack-gnome-hu language-pack-hu-base language-pack-gnome-hu-base

#+OFFICE
sudo apt-get install -y libreoffice-presentation-minimizer libreoffice-l10n-hu aspell-hu hunspell-hu aspell-en hunspell-en-us

#+MEDIA
sudo apt-get install -y vlc phatch nautilus-image-converter audacity picard puddletag gimp

# Skype telepítése
#Ubuntu - enable "partner" repository
#sudo sed -i "/^# deb .*partner/ s/^# //" /etc/apt/sources.list
#sudo apt-get update
#sudo apt-get install -y skype

#  Skype honlap - Website:
#http://www.skype.com/hu/download-skype/skype-for-linux/downloading/?type=ubuntu64
wget get.skype.com/go/getskype-linux-beta-ubuntu-64 -O skype.deb
sudo apt-get install -y gdebi
sudo gdebi --n skype.deb

# Skype magyar nyelvi fájl telepítése
wget http://urbalazs.hu/blog/uploads/skype_hu_4.3.0.37.tar.gz
sudo tar -C /usr/share/skype/lang -xzf skype_hu_4.3.0.37.tar.gz

# Audex Hang CD átalakító program  - Audex CD ripper application:
sudo apt-get install -y audex

# Nem szükséges programok eltávolítása -  Remove unneeded apps - OPTIONAL
sudo apt-get purge -y brasero

# Install Chromium + default incognito mode
sudo apt-get install -y chromium-browser
sudo perl -pi -e 's?Exec=chromium-browser?Exec=chromium-browser --incognito?g' /usr/share/applications/chromium-browser.desktop

# Védett mód - protected mode
# http://sourceforge.net/projects/firejail/files/firejail/
sudo perl -pi -e 's?Exec=chromium-browser?Exec=firejail chromium-browser --incognito?g' /usr/share/applications/chromium-browser.desktop

#+Google Chrome
sudo deb http://dl.google.com/linux/deb/ stable non-free main
sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

# Run Windows applications - Office 2003/2007/2010, Total Commander, Photoshop, games, etc...
# See AppDB: https://appdb.winehq.org/
yes | sudo add-apt-repository ppa:ubuntu-wine/ppa

# Ubuntu Tweak telepítése
yes | sudo add-apt-repository ppa:tualatrix/ppa

# INSTALL FROM EXTRA REPOSITORIES
sudo apt-get update
sudo apt-get install -y google-chrome-stable
sudo apt-get install -y ubuntu-tweak
sudo apt-get install -y playonlinux winetricks wine1.7

# Apport letiltása - megszűnnek a bosszantó rendszerösszeomlás-jelentések
# Disable apport - remove annoying system crash messages
sudo perl -pi -e 's/enabled=1/enabled=0/g' /etc/default/apport

# Swap only after 90% RAM is full
echo "vm.swappiness = 10" | sudo tee -a /etc/sysctl.conf

# END OF AUTOMATED PART
exit 0

# Szoftver tárolók könnyű hozzáadása
# Add repositories easily:
sudo apt-get install -y python-software-properties

# Krita képszerkesztő és digitális festőprogram - Krita image editor and digital painter
yes | sudo add-apt-repository ppa:kubuntu-ppa/backports 
sudo apt-get update
sudo apt-get install -y krita

# e.g. install MUMBLE VoIP client:
yes | sudo add-apt-repository ppa:mumble/release
sudo apt-get update
sudo apt-get install -y mumble

# SWF fájlok megnyitása böngészőben - Play SWF files in browser
sudo perl -pi -e 's?<mime-type type="application/vnd.adobe.flash.movie">?<mime-type type="application/x-shockwave-flash">?g' /usr/share/mime/packages/freedesktop.org.xml
sudo update-mime-database /usr/share/mime

# Installing MATE in Ubuntu 14.04 LTS
yes | sudo apt-add-repository ppa:ubuntu-mate-dev/ppa
yes | sudo apt-add-repository ppa:ubuntu-mate-dev/trusty-mate
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install --no-install-recommends ubuntu-mate-core ubuntu-mate-desktop

# TEAMVIEWER - Távsegítség program telepítése - REMOTE HELP
wget http://download.teamviewer.com/download/teamviewer_i386.deb
sudo apt-get install -y gdebi
sudo gdebi --n teamviewer_i386.deb
