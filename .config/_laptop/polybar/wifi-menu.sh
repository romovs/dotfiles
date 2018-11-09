#!/usr/bin/env bash

# based on https://github.com/zbaylin/rofi-wifi-menu

FIELDS=SSID,BSSID,CHAN,FREQ,RATE,SIGNAL,BARS,SECURITY,DEVICE
POSITION=3
YOFF=28
XOFF=-2
FONT="Droid Sans Mono 12"
HEADERLINES=2
MAXSSIDS=14

STATE=$(nmcli -fields WIFI g | sed -n '1!p')

disabled() {
    TOGGLE="toggle on"
    CHENTRY=$(echo -e "$TOGGLE" | rofi -dmenu -p "wifi is off" -lines "1" -location "$POSITION" -yoffset "$YOFF" -xoffset "$XOFF" -font "$FONT" -width -"70")
    if [ "$CHENTRY" = "$TOGGLE" ]; then
        nmcli radio wifi on
    fi
}

enabled() {
    LIST=$(nmcli --fields "$FIELDS" device wifi list | sed '/^--/d')
    # For some reason rofi always approximates character width 2 short... hmmm
    RWIDTH=$(($(echo "$LIST" | head -n 1 | awk '{print length($0); }')+2))
    LINENUM=$(echo "$LIST" | wc -l)
    # Gives a list of known connections so we can parse it later
    KNOWNCON=$(nmcli connection show)
    # Really janky way of telling if there is currently a connection
    CURRSSID=$(iwgetid -r)
    TOGGLE="toggle off"

    if [[ ! -z $CURRSSID ]]; then
        HIGHLINE=$(echo  "$(echo "$LIST" | awk -F "[  ]{2,}" '{print $1}' | grep -Fxn -m 1 "$CURRSSID" | awk -F ":" '{print $1}') + 1" | bc ) 
    fi

    # display max 13 SSIDs (we get SSIDs + header from nmcli)
    if [ "$LINENUM" -gt "$MAXSSIDS" ]; then
        LINENUM=$(($MAXSSIDS + $HEADERLINES))
    else
        LINENUM=$(($LINENUM + $HEADERLINES))
    fi

    eval FIELDSARR=( $(echo -e "$FIELDS" | awk 'BEGIN { FS=","; OFS="\n" } /^FIELDS/ { $1 = substr($1, 8); print $0; }') )

    for i in "${!FIELDSARR[@]}"; do
        if [[ "${FIELDSARR[$i]}" = "SSID" ]]; then
            SSID_POS="${i}";
        fi
    done

    let AWKSSIDPOS=$SSID_POS+1

    CHENTRY=$(echo -e "$TOGGLE\nmanual\n$LIST" | uniq -u | rofi -dmenu -p "SSID" -lines "$LINENUM" -a "$HIGHLINE" -location "$POSITION" -yoffset "$YOFF" -xoffset "$XOFF" -font "$FONT" -width -"$RWIDTH")

    CHSSID=$(echo "$CHENTRY" | sed  's/\s\{2,\}/\|/g' | awk -F "|" '{print $'$AWKSSIDPOS'}')

    # If the user inputs "manual" as their SSID in the start window, it will bring them to this screen
    if [ "$CHENTRY" = "manual" ] ; then
        # Manual entry of the SSID and password (if appplicable)
        MSSID=$(echo "enter the SSID of the network (SSID,password)" | rofi -dmenu -p "Manual Entry" -font "$FONT" -lines 1)
        # Separating the password from the entered string
        MPASS=$(echo "$MSSID" | awk -F "," '{print $2}')

        # If the user entered a manual password, then use the password nmcli command
        if [ "$MPASS" = "" ]; then
            nmcli dev wifi con "$MSSID"
        else
            nmcli dev wifi con "$MSSID" password "$MPASS"
        fi
    elif [ "$CHENTRY" = "$TOGGLE" ]; then
        nmcli radio wifi off
    else
        # If the connection is already in use, then this will still be able to get the SSID
        if [ "$CHSSID" = "*" ]; then
            CHSSID=$(echo "$CHENTRY" | sed  's/\s\{2,\}/\|/g' | awk -F "|" '{print $3}')
        fi

        # Parses the list of preconfigured connections to see if it already contains the chosen SSID. This speeds up the connection process
        if [[ $(echo "$KNOWNCON" | grep "$CHSSID") = "$CHSSID" ]]; then
            nmcli con up "$CHSSID"
        else
            if [[ "$CHENTRY" =~ "WPA2" ]] || [[ "$CHENTRY" =~ "WEP" ]]; then
                WIFIPASS=$(echo "if connection is stored, hit enter" | rofi -dmenu -p "password" -lines 1 -font "$FONT" )
            fi
            nmcli dev wifi con "$CHSSID" password "$WIFIPASS"
        fi
    fi
}

if [[ "$STATE" =~ "enabled" ]]; then
    enabled
else
    disabled
fi
