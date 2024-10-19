#!/bin/bash

# Update current-wallpaper.png
cp $1 ~/.backgrounds/current-wallpaper.png
# Change background
swww img $1
# Generate palette
wal -i $1 --cols16 -n --contrast 3 -a 50
# Prevent duplicate waybar instances from modifications to hyprland.conf colors
killall waybar
waybar &
# Import palette into Gradience
gradience-cli import -p ~/.cache/wal/pywal.json
# Apply Gradience pallete to GTK theme
gradience-cli apply -n pywal
# Run script to apply pywal theme to Mako notifications
~/.scripts/update-mako-theme.sh
# Send a notification
notify-send "Theme updated"
