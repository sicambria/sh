#!/bin/bash
WATERMARK="watermark700.png"
resize=2000

#Choices include: NorthWest, North, NorthEast, West, Center, East, SouthWest, South, SouthEast.
WATERMARKPOS=SouthEast

OPACITY=60
QUALITY=85

DIR="."

clear
echo
echo "This script will OVERWRITE the source files, so work on a copy!"
echo

if [ $# -eq 1 ]
then
    #-----if there is a parameter----
    DIR="$1"
    echo "Target directory: $DIR"
else
    echo -n "No parameter, current directory is: "
    pwd
    echo
fi


read -p "Watermark with file \""$WATERMARK"\" & resize all images to width "$resize"? (y/n)  " prompt

if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
 echo ""
 shopt -s nullglob

 for each in $DIR/*{.jpg,.jpeg,.JPG,.JPEG}
 do
  echo -n "Working on "$each" ..."
  convert -resize $resize "$each" "$each" >> /dev/null
  composite -gravity $WATERMARKPOS -quality $QUALITY -dissolve $OPACITY $WATERMARK "$each" "$each" >> /dev/null
  echo "[Done]"
 done

# ---
  echo ""
  read -p "Press Enter to exit ..."
else
 exit 0
fi
