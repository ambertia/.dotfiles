#!/bin/bash
find "${HOME}/.backgrounds/" -maxdepth 1 -type f \( -iname "*.png" \) -exec basename {} \; | sort | while read -r A; do echo -en "$A\x00icon\x1f"".backgrounds/$A\n" ; done | rofi -dmenu -p "~/.backgrounds/" -config ${HOME}/.config/rofi/imagepicker.rasi
