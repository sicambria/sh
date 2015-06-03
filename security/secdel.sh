#!/bin/bash

if ! type "srm" > /dev/null 2>&1; then
  sudo apt-get install secure-delete
fi


if [ $1 ]
then
    echo "Target folder given: $1"
    FOLDER="$1"
    cd $1 2>/dev/null
    if [[ $? -eq 1 ]]
    then
        echo "Target folder does not exist, exiting!"
        exit 1
    fi
else
    echo "Targeting current directory."
    FOLDER=`pwd`
fi

echo
echo -n "WE ARE IN: "
pwd
read -p "CAUTION! Are you sure to shred this entire folder? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo
    ls
    echo
    echo "ALL FILES HERE and also in SUBDIRECTORIES WILL BE ERASED!"
    echo "FOLDER NAME: $FOLDER"
    echo -n "FULL PATH: "
    pwd
    echo "--------------------------------------"
    read -p "!!! - CONFIRM AGAIN (capital Y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Y]$ ]]
    then
        if [[ -e $1 ]]
        then
             find "$1" -type f -execdir shred -uvzn 3 '{}' \;
             srm -sR "$1"
        else
             find . -type f -execdir shred -uvzn 3 '{}' \;
             srm -sR .
        fi
    else
        echo "Exiting, no action."
        exit 1
    fi
fi
