#!/bin/bash

IFS=""

echo "This script searches for WhatsApp and Android camera pictures and videos in the specified search path and moves them to"
echo "$HOME/Pictures/[WhatsApp?]/[year]/[month]/[Videos?] based on it's filenames to put them separated by year and month"
read -e -p "Enter the path you want to search for media: " findPath

declare -a patterns=(".*IMG-[0-9]\{8\}-WA[0-9]\{4\}.*" ".*VID-[0-9]\{8\}-WA[0-9]\{4\}.*" ".*IMG_[0-9]\{8\}_[0-9]\{6\}.*" ".*VID_[0-9]\{8\}_[0-9]\{6\}.*" ".*PANO_[0-9]\{8\}_[0-9]\{6\}.*")

for pattern in "${patterns[@]}"
do
    find "$findPath" -regextype sed -regex "$pattern" \
    |while read path
    do
        if [[ $path != *"Instagram"* ]]
        then
            filename=$(basename "$path")
            year=${filename:4:4}
            month=${filename:8:2}
            if [[ "$pattern" == ".*IMG-[0-9]\{8\}-WA[0-9]\{4\}.*" ]]
            then
                movePath=$HOME/Pictures/WhatsApp/$year/$month
            elif [[ "$pattern" == ".*VID-[0-9]\{8\}-WA[0-9]\{4\}.*" ]]
            then
                movePath=$HOME/Pictures/WhatsApp/$year/$month/Videos
            elif [[ "$pattern" == ".*IMG_[0-9]\{8\}_[0-9]\{6\}.*" ]]
            then
                movePath=$HOME/Pictures/$year/$month
            elif [[ "$pattern" == ".*VID_[0-9]\{8\}_[0-9]\{6\}.*" ]]
            then
                movePath=$HOME/Pictures/$year/$month/Videos
            elif [[ "$pattern" == ".*PANO_[0-9]\{8\}_[0-9]\{6\}.*" ]]
                year=${filename:5:4}
                month=${filename:9:2}
                movePath=$HOME/Pictures/$year/$month
            fi

            if [ ! -e $movePath ]
            then
                mkdir -p $movePath
            fi
            echo Moving $path to $movePath
            mv "$path" $movePath
        fi
    done
done
