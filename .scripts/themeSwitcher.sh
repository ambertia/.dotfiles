#!/bin/bash

BACKGROUND_PATH=${1}
echo $BACKGROUND_PATH

# Update current-wallpaper
cp $BACKGROUND_PATH $HOME/.backgrounds/current-wallpaper
# Change background
swww img $BACKGROUND_PATH
# Generate palette
wal -i $BACKGROUND_PATH --cols16 -n --contrast 2 -a 50
# Import palette into Gradience
gradience-cli import -p ~/.cache/wal/pywal.json
# Apply Gradience pallete to GTK theme
gradience-cli apply -n pywal
# Run script to apply pywal theme to Mako notifications
~/.scripts/update-mako-theme.sh
# Send a notification
notify-send "Theme updated"
# Prevent duplicate waybar instances from modifications to hyprland.conf colors
killall waybar && waybar &

