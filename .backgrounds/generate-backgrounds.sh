#!/bin/bash

# Amber's Dotfiles

# This script is meant to take all of the original downloaded images and
# crop them to a specific aspect ratio using imagemagick. PNG's get
# repaged, JPG's do not. Aspect ratio can be modified using the variable
# below, although I designed this mainly for my laptop where there will
# only be one screen with this specific aspect ratio 99.9% of the time.

ASPECT_RATIO="3:2"

# Remove all files in originals/
rm -f originals/*

# Retreive images from all URLs in sources.txt and store in originals/
wget --input-file=sources.txt --directory-prefix=originals

# Convert jpgs to png because hyprlock only supports png at the moment
(cd originals && mogrify -format png *.jpg)

# Minimally crop to aspect ratio, repage, and put up in the main .backgrounds directory
(cd originals && mogrify -gravity center -crop $ASPECT_RATIO +repage -path ../ *.png)
