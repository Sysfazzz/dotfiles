#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/your/wallpaper.png"
    exit 1
fi

WALLPAPER=$1

if [ ! -f "$WALLPAPER" ]; then
    echo "Error: The file '$WALLPAPER' does not exist."
    exit 1
fi

echo "Applying wallpaper and generating colors..."

awww img "$WALLPAPER" \
    --transition-type random \
    --transition-duration 2 \
    --transition-fps 60 \
    --transition-bezier 0.65,0,0.35,1

matugen image "$WALLPAPER" -t scheme-tonal-spot --source-color-index 0

echo "Theme successfully updated!"
