#!/bin/bash

# Fn+L - low power
# Fn+M - balanced
# Fn+H - performance

# list of available modes is available from:
# cat /sys/firmware/acpi/platform_profile_choices

PROFILE=$(cat /sys/firmware/acpi/platform_profile)

if [[ "${PROFILE}" = "low-power" ]]; then
    echo "%{F#6b6b6b}%{F-} %{F#95cae3}L%{F-}"
elif [[ "${PROFILE}" = "balanced" ]]; then
    echo "%{F#6b6b6b}%{F-} %{F#f9e2af}M%{F-}"
elif [[ "${PROFILE}" = "performance" ]]; then
    echo "%{F#6b6b6b}%{F-} %{F#f92672}H%{F-}"
fi
