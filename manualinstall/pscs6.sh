#!/bin/bash

mkdir ~/install
PS_Installer_Directory="~/install"

sudo add-apt-repository ppa:ubuntu-wine/ppa 
sudo apt-get update 
sudo apt-get install wine1.7 winetricks

winetricks atmlib gdiplus msxml3 vcrun2005 vcrun2005sp1 vcrun2008 fontsmooth-rgb gecko 

# Start the installer:
cd $PS_Installer_Directory
wine setup.exe

exit 0

# If installer fails, try the 32-bit wineprefix:

mv ~/.wine
~/.wine
_backup

WINEARCH=win32 WINEPREFIX=~/.wine winecfg

winetricks atmlib gdiplus msxml3 vcrun2005 vcrun2005sp1 vcrun2008 fontsmooth-rgb gecko 

cd $PS_Installer_Directory
wine setup.exe 
