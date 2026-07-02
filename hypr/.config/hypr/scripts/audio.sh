#!/bin/bash

action=$(echo -e "  Audio Output (Sinks)\n  Audio Input (Sources)" | rofi -dmenu -i -p "Configure:" -theme ~/.config/rofi/audio.rasi)

if [ -z "$action" ]; then
    exit
fi

if [[ "$action" == *"Output"* ]]; then
    devices=$(pactl list sinks | grep -e 'Description:' | cut -d: -f2- | sed 's/^[ \t]*//')
    chosen_device=$(echo "$devices" | rofi -dmenu -i -p "Output:" -theme ~/.config/rofi/audio.rasi)
    
    if [ -z "$chosen_device" ]; then
        exit
    fi
    
    device_name=$(pactl list sinks | grep -B 1 -A 2 "Description: $chosen_device" | grep 'Name:' | awk '{print $2}')
    
    if pactl set-default-sink "$device_name"; then
        notify-send -t 3000 "Audio Output" "Switched to $chosen_device"
    else
        notify-send -u critical -t 3000 "Audio Error" "Failed to switch output device."
    fi

elif [[ "$action" == *"Input"* ]]; then
    devices=$(pactl list sources | grep -e 'Description:' | grep -v 'Monitor of' | cut -d: -f2- | sed 's/^[ \t]*//')
    chosen_device=$(echo "$devices" | rofi -dmenu -i -p "Input:" -theme ~/.config/rofi/audio.rasi)
    
    if [ -z "$chosen_device" ]; then
        exit
    fi
    
    device_name=$(pactl list sources | grep -B 1 -A 2 "Description: $chosen_device" | grep 'Name:' | awk '{print $2}')
    
    if pactl set-default-source "$device_name"; then
        notify-send -t 3000 "Audio Input" "Switched to $chosen_device"
    else
        notify-send -u critical -t 3000 "Audio Error" "Failed to switch input device."
    fi
fi