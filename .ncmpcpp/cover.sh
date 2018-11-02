#!/bin/bash

# Shows cover art in the bottom right corner of ncmpcpp running from uxvrt.
# Intended to be executed by execute_on_song_change.
# Assumes 60% split and 1680x1050 fullscreen [desktop] (480 size) or 1920x1080 split screen [laptop] (370)

dir=$(dirname "$HOME/Music/$(mpc current -f %file%)") 
cover="$(find "$dir" -type d -exec find {} -maxdepth 1 -type f -iregex ".*\.\(jpe?g\|png\|gif\|bmp\)" \; | head -n1)"

if [[ -n "$cover" ]] ; then
    convert "$cover" -resize 370 /tmp/cover.jpg
    printf "\e]20;/tmp/cover.jpg;0x0+99+93:op=keep-aspect\a"
else
    # Hide previous image.
    printf "\e]20;;+1000\a"
fi
