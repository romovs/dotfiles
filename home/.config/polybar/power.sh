#!/bin/bash

# Fn+L - low profile
# Fn+M - balanced
# Fn+H - performance

PROFILE=$(cat /sys/firmware/acpi/platform_profile)

if [[ "${PROFILE}" = "low-power" ]]; then
    echo "%{F#6b6b6b}%{F-} %{F#95cae3} low%{F-}"
elif [[ "${PROFILE}" = "balanced" ]]; then
    echo "%{F#6b6b6b}%{F-} %{F#e6db74} med%{F-}"
elif [[ "${PROFILE}" = "performance" ]]; then
    echo "%{F#6b6b6b}%{F-} %{F#f92672}high%{F-}"
fi
