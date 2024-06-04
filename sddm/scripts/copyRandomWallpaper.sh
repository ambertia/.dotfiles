#!/bin/bash

# Get the path to the theme's folder
SDDM_CORNERS_FOLDER="/usr/share/sddm/themes/corners"

# Get a random image file from the theme's background images folder (symlink to $USER_HOME/.backgrounds)
IMAGE_FILE=$(find -L $SDDM_CORNERS_FOLDER/backgrounds -type f \( -name '*.png' -o -name '*.jpg' \) | shuf -n 1)

# Copy a random wallpaper - SDDM can't seem to actually use symlink to my home folder when I'm not logged in
# The script is executed with superuser privilege and can therefore *copy* the image, but SDDM itself can't
# access the original file in the user directory
cp -f "$IMAGE_FILE" "$SDDM_CORNERS_FOLDER/randomlySelectedWallpaper"
