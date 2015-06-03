#!/bin/bash
# Bash script to automatically sort photos into folders based on EXIF data for GNU/Linux
# Lite version by GW (v2013-04-02)
# Original script source:
# http://mikebeach.org/2011/12/10/bash-script-to-automatically-sort-photos-into-folders-based-on-exif-data-for-ubuntu-linux/
# ----------------------------------------------------
# Warning! This script is just a PoC, use with care!
# ----------------------------------------------------

TARGETFOLDER="$1"
if [[ "$TARGETFOLDER" == "" ]]; then
    echo "Please specify the target (source) folder to sort."
    exit
fi

FILETYPES=("*.jpg" "*.jpeg" "*.png" "*.tif" "*.tiff" "*.gif" "*.xcf")

for x in "${FILETYPES[@]}"; do
 # Check for the presence of imagemagick and the identify command.
 # Assuming its valid and working if found.
 I=`which identify`
 if [ "$I" == "" ]; then
     echo "The 'identify' command is missing or not available."
    echo "Is imagemagick installed?"
    exit 1
 fi;

 echo "Scanning for $x..."
 # FIXME? Eliminate problems (if any) with unusual characters in filenames.

cd $1


result=`echo $1 | tail -c 2`
if [[ "$result" != "/" ]]
then
    echo "Trailing / (slash) required for path! Exiting."
    exit 1
fi


mkdir $1other
mkdir $1bin

 for file in `find $1 -maxdepth 1 -iname "$x"`; do
    #  echo "Item is: $file"
      
    identify -verbose $file | grep "exif:DateTime:" | awk -F\  '{print $2}' | sed s/:/-/g | { read mydate; 
    if [[ $mydate == "" ]]; 
    then 
        mv -i "$file" "$1other" ; echo "MOVE $file TO $1other " ; 
    else 
        mymonth=`echo "$mydate" | cut -c 1-7` ; echo "--- Month: $mymonth " ; mkdir $1$mymonth 2>/dev/null ;
        echo " DATE: $mydate MOVE ITEM: $file TO: $1$mymonth/$mydate "; 
        mkdir "$1$mymonth/$mydate" 2>/dev/null ; mv -i "$file" "$1$mymonth/$mydate";

        if [[ $? -ne 0 ]]; 
            then mv -i "$file" "$1bin"; echo "MOVE $file TO $1bin " ; 
        fi ;

    fi ; }  
      done
 echo "... end of $x"
done;
