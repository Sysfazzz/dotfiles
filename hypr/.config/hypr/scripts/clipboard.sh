#!/bin/bash

raw_list=$(cliphist list)

chosen=$(echo "$raw_list" | cut -f2- | rofi -dmenu -i -p "Search Clipboard:" -theme ~/.config/rofi/clipboard.rasi)

if [ -z "$chosen" ]; then
    exit
fi

echo "$raw_list" | awk -F'\t' -v target="$chosen" '$2 == target {print $0; exit}' | cliphist decode | wl-copy

notify-send -t 3000 "Clipboard" "Copied to clipboard! 📋"