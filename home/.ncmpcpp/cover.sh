#!/bin/bash

# Shows cover art in the bottom right corner of ncmpcpp running from uxvrt.
# Intended to be executed by execute_on_song_change.
# Assumes 60% split and 1680x1050 fullscreen [desktop] (480 size) or 1920x1080 split screen [laptop] (370)

dir=$(dirname "/mnt/data/data/music/$(mpc current -f %file%)") 
cover="$(find "$dir" -type d -exec find {} -maxdepth 1 -type f -iregex ".*\.\(jpe?g\|png\|gif\|bmp\)" \; | head -n1)"

# without random name urxvt+ncmpcpp for some reason cannot set image more than once (perhaps due to some caching feature?)
filename=$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 32)

if [[ -n "$cover" ]] ; then
    convert "$cover" -resize 370 /tmp/${filename}.jpg
    echo -e "\e]20;/tmp/${filename}.jpg;0x0+99+93:op=keep-aspect\a\n"
    # remove the image so we won't have tons of temp files lying around
    rm /tmp/${filename}.jpg
else
    # hide previous image.
    printf "\e]20;;+1000\a"
fi
