#!/bin/bash

MAP="$HOME/.config/rofi/apps.csv"

MENU=$(cat "$MAP" | cut -d ',' -f 1)

echo -e $MENU \
    | rofi -dmenu -i -show-icons -p "launch" \
    | head -n 1 \
    | xargs -i --no-run-if-empty grep "{}" "$MAP" \
    | cut -d ',' -f 2 \
    | head -n 1 \
    | xargs -i --no-run-if-empty /bin/bash -c "{}"

exit 0