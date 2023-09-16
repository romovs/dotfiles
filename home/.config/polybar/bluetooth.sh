#!/bin/sh

print() {
  if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
  then
      echo "%{F#6b6b6b}%{F-} %{F#6b6b6b}off%{F-}"
  else
      DEVICE_LINE=$(bluetoothctl info | grep 'Name')
      if [ $(echo $DEVICE_LINE | wc -c) -le 1 ]
      then 
        echo "%{F#6b6b6b}%{F-} %{F#95cae3}on%{F-}"
      else
        DEVICE_NAME=$(echo $DEVICE_LINE | cut -d':' -f2-)
        echo "%{F#6b6b6b}%{F-}%{F#95cae3}$DEVICE_NAME%{F-}"
      fi
  fi
}

toggle() {
  if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
  then
    bluetoothctl power on
  else
    bluetoothctl power off
  fi
}

case "$1" in
    --toggle)
        toggle
        ;;
    *)
        print
        ;;
esac