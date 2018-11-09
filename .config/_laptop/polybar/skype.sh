#!/bin/bash

BADGES=$(<~/.config/skypeforlinux/badge_count)

if [[ ${BADGES} -gt 0 ]]; then
    echo "%{F#e60053}%{F-} %{F#e60053}${BADGES}%{F-}"
else
    echo "%{F#6b6b6b}%{F-} %{F#95cae3}~%{F-}"
fi
