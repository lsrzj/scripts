#!/bin/bash

IFS=""

echo "This script searches for WhatsApp pictures and videos in the specified search path and moves them to"
echo "$HOME/Pictures/WhatsApp/[year]/[month] based on it's filenames to put them separated by year and month"
read -e -p "Enter the path you want to search WhatsApp media: " findPath

find "$findPath" -regextype sed -regex '.*IMG-[0-9]\{8\}-WA[0-9]\{4\}.*' \
| \
while read path
do
    filename=$(basename "$path")
    year=${filename:4:4}
    month=${filename:8:2}
    if [ ! -e $HOME/Pictures/WhatsApp/$year/$month ]
    then
        mkdir -p $HOME/Pictures/WhatsApp/$year/$month
    fi
    mv "$path" $HOME/Pictures/WhatsApp/$year/$month
    echo Moving $path to $HOME/Pictures/WhatsApp/$year/$month
done

find "$findPath" -regextype sed -regex '.*VID-[0-9]\{8\}-WA[0-9]\{4\}.*' \
| \
while read path
do
    filename=$(basename "$path")
    year=${filename:4:4}
    month=${filename:8:2}
    if [ ! -e $HOME/Pictures/WhatsApp/$year/$month/Videos ]
    then
        mkdir -p $HOME/Pictures/WhatsApp/$year/$month/Videos
    fi
    mv "$path" $HOME/Pictures/WhatsApp/$year/$month/Videos
    echo Moving $path to $HOME/Pictures/WhatsApp/$year/$month/Videos
done
