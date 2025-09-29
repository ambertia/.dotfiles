#!/bin/bash

local BACKGROUND_PATH
FILE_NAME=$(\
    find "${HOME}/.backgrounds/" \
        -maxdepth 1 \
        -type f \( -iname "*.png" \) \
        -exec basename {} \; | \
    sort | \
    while read -r A; do \
        echo -en "$A\x00icon\x1f"".backgrounds/$A\n" ; \
    done | \
    rofi -dmenu -p "~/.backgrounds/" -config ${HOME}/.config/rofi/imagepicker.rasi
)
RETURN_STATUS=$?
BACKGROUND_PATH="${HOME}/.backgrounds/${FILE_NAME}"
if [ $RETURN_STATUS -eq 1 ]; then
    exit
fi

# Update current-wallpaper
cp $BACKGROUND_PATH $HOME/.backgrounds/current-wallpaper
# Change background
swww img $BACKGROUND_PATH
# Generate palette
wal -i $BACKGROUND_PATH --cols16 -n --contrast 1.5 -a 50
# Run script to apply pywal theme to Mako notifications
~/.scripts/update-mako-theme.sh
# Prevent duplicate waybar instances from modifications to hyprland.conf colors
sleep 2
killall waybar && killall cava && waybar &
# Send a notification
notify-send "Theme updated"

