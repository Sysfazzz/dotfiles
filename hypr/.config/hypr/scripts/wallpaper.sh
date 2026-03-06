#!/bin/bash

WALL_DIR="$HOME/dotfiles/wallpapers"

menu_items=""
while read -r file; do
    filename=$(basename "$file")
    
    menu_items+="${filename}\0icon\x1f${file}\n"
done < <(find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \))

chosen=$(echo -en "$menu_items" | rofi -dmenu -i -show-icons -theme ~/.config/rofi/wallpaper.rasi)

if [ -z "$chosen" ]; then
    exit
fi

full_path="$WALL_DIR/$chosen"

~/.config/hypr/scripts/wallset.sh "$full_path"

notify-send -t 3000 "Wallpaper Engine" "Applying $chosen and regenerating colors..."
