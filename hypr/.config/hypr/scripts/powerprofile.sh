#!/bin/bash

options="  Performance\n  Balanced\n  Power Saver"

chosen=$(echo -e "$options" | rofi -dmenu -i -theme ~/.config/rofi/powerprofile.rasi)

if [ -z "$chosen" ]; then
    exit
fi

case "$chosen" in
    *"Performance"*)
        powerprofilesctl set performance
        notify-send -t 3000 "Power Profile" "Switched to Performance Mode "
        ;;
    *"Balanced"*)
        powerprofilesctl set balanced
        notify-send -t 3000 "Power Profile" "Switched to Balanced Mode "
        ;;
    *"Power Saver"*)
        powerprofilesctl set power-saver
        notify-send -t 3000 "Power Profile" "Switched to Power Saver Mode "
        ;;
esac