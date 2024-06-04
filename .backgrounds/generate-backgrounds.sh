#!/bin/bash

# Amber's Dotfiles

# This script is meant to take all of the original downloaded images and
# crop them to a specific aspect ratio using imagemagick. PNG's get
# repaged, JPG's do not. Aspect ratio can be modified using the variable
# below, although I designed this mainly for my laptop where there will
# only be one screen with this specific aspect ratio 99.9% of the time.

ASPECT_RATIO="3:2"
(cd originals && mogrify -gravity center -crop $ASPECT_RATIO +repage -path ../ *.png)
(cd originals && mogrify -gravity center -crop $ASPECT_RATIO -path ../ *.jpg)
