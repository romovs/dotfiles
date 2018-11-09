#!/bin/bash

BAT_STATE=$(upower -i $(upower -e | grep 'BAT0') | grep -E "state" | awk '{print $2}')
BAT0_POWER=$(upower -i $(upower -e | grep 'BAT0') | grep -E "percentage" | awk '{print $2}' | tr -d '%')
BAT1_POWER=$(upower -i $(upower -e | grep 'BAT1') | grep -E "percentage" | awk '{print $2}' | tr -d '%')
POWER=$(((BAT0_POWER + BAT1_POWER) / 2))
POWER_PADDED=$(printf "%3s" $POWER)
DANGER=15

if [[ "${POWER}" -gt 90 ]]; then
    BAT_ICON=""
elif [[ "${POWER}" -gt 75 ]]; then
    BAT_ICON=""
elif [[ "${POWER}" -gt 50 ]]; then
    BAT_ICON=""
elif [[ "${POWER}" -gt 25 ]]; then
    BAT_ICON=""
elif [[ "${POWER}" -le ${DANGER} ]]; then
    BAT_ICON=""
fi

if [[ "${BAT_STATE}" = "discharging" ]]; then
    if [[ ${POWER} -le ${DANGER} ]]; then
        echo "%{F#6b6b6b}${BAT_ICON}%{F-} %{F#e60053}${POWER_PADDED}%%{F-}"
    else
        echo "%{F#6b6b6b}${BAT_ICON}%{F-} %{F#95cae3}${POWER_PADDED}%%{F-}"
    fi
else
    echo "%{F#6b6b6b}%{F-} %{F#95cae3}${POWER_PADDED}%%{F-}"
fi