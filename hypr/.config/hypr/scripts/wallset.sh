#!/bin/bash

# 1. Check if the user actually provided a wallpaper path
if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/your/wallpaper.png"
    exit 1
fi

WALLPAPER=$1

# 2. Check if the file exists
if [ ! -f "$WALLPAPER" ]; then
    echo "Error: The file '$WALLPAPER' does not exist."
    exit 1
fi

echo "Applying wallpaper and generating colors..."

# 3. Change the wallpaper using swww with a center circle transition
swww img "$WALLPAPER" \
    --transition-type grow \
    --transition-pos 0.5,0.5 \
    --transition-duration 1.2 \
    --transition-fps 60 \
    --transition-bezier 0.65,0,0.35,1

# 4. Generate the new color palette with Matugen
matugen image "$WALLPAPER"

echo "Theme successfully updated!"