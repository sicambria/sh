#!/bin/sh
mkdir tmp 2>/dev/null
cp $@ tmp
cd tmp
clear
echo
echo "Processing $@..."
pdftoppm *.pdf -f 1 -l 100 -r 600 ocrbook 2>error.txt

for i in *.ppm; do
echo "CONVERT: $i"
convert "$i" "`basename "$i" .ppm`.tif"; done

for i in *.tif; do 
echo "OCR: $i"
# -l hun  -->> OCR for HUNGARIAN LANGUAGE
tesseract 1>/dev/null 2>error.txt "$i" "`basename "$i" .tif`" -l hun; done
for i in *.txt; do cat $i >> pdf-ocr-output.txt; echo "\n[$1]\n" >> pdf-ocr-output.txt; done
mv pdf-ocr-output.txt ..

# Cleanup
mkdir text 2>/dev/null
mv *.txt text 2>/dev/null
rm * 2>/dev/null
cd ..
#rmdir tmp
