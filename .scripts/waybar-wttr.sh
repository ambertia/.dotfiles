#!/bin/bash

# --------------------------------------------------------------------
# BUILD QUERIES
# --------------------------------------------------------------------

# Get the location query to use from a file if it exists. Otherwise, leaving
# it blank will default the location to whatever wttr gleans from your IP.
# Writing the token as <city>,%20<state> provides implicit formatting while
# being specific enough to be useful.
location_token=""
if [ -f $HOME/.cache/.dotfiles/wttr_token ]; then
    location_token=$(cat $HOME/.cache/.dotfiles/wttr_token)
fi

text_data="%t+%c"
tooltip_data="%l.+%w+%h+UV:%u"

text_wttr_url="wttr.in/${location_token}?m&format=${text_data}"
tooltip_wttr_url="wttr.in/${location_token}?format=${tooltip_data}"

# --------------------------------------------------------------------
# PRINTF RETURN
# --------------------------------------------------------------------

# Return data to Waybar in JSON.

printf '{"text": "%s", "tooltip": "%s"}' \
    "$(curl $text_wttr_url)" \
    "$(curl $tooltip_wttr_url)"
