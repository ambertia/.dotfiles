#! /bin/bash

#---------------------------------------------------------------------
# GET BATTERY INFORMATION
#---------------------------------------------------------------------

# Get voltage from the kernel and store it in mV
voltage_now=$(( $(cat /sys/class/power_supply/BAT1/voltage_now) / 1000 ))

# Get current from the kernel and store it in mA
current_now=$(( $(cat /sys/class/power_supply/BAT1/current_now) / 1000 ))

# Calculate power in uW
power_now=$(( $voltage_now * $current_now ))

# Get battery state from the kernel
battery_status=$(cat /sys/class/power_supply/BAT1/status)

#---------------------------------------------------------------------
# STATUS-BASED CACHING
#---------------------------------------------------------------------

# The file to be used to store the max power as a cache (convenient way to track
# a maximum for the given system
POWER_MAX_CACHE="$HOME/.cache/.dotfiles/power_max_${battery_status}"

# Default power_max to power_now, but try to retreive it from a file
power_max=$power_now
if [ -f $POWER_MAX_CACHE ]; then
    power_max=$(cat $POWER_MAX_CACHE)
fi

# Write to the max power cache if the value had to be defaulted (the cache
# doesn't exist) or if the value is greater than the existing max (adapt the
# scale)
# TODO this requires the ~/.cache/.dotfiles directory to exist. Make it here or ensure it's made on install.
if [ "$power_now" -ge "$power_max" ]; then
    echo $power_now > $POWER_MAX_CACHE
    power_max=$power_now
fi

#---------------------------------------------------------------------
# FORMATTING ARITHMETIC
#---------------------------------------------------------------------

# Do some funky math to allow printing decimal numbers using only integer variables
power_now_whole=$(( $power_now / 1000000 ))
power_now_frac=$(( ( $power_now % 1000000 ) / 10000 ))

power_max_whole=$(( $power_max / 1000000 ))
power_max_frac=$(( ( $power_max % 1000000 ) / 10000 ))

# Calculate the power_now percentage relative to power_max
# Dividing the divisor by 100 first gives an accurate percentage via pure integer math
percentage=$(( $power_now / $(( $power_max / 100 )) ))

#---------------------------------------------------------------------
# CONDITIONAL FORMATTING
#---------------------------------------------------------------------

# Conditionally choose a color for the bar and apply it with a style class
# I tried to use a span to control the color and thus contain the clutter in
# this file, but manually coloring the span overrides the on-hover styling
if [ $percentage -le 25 ]; then
    if [ "$battery_status" = "Discharging" ]; then
        STYLE_CLASS="discharging-low"
    else
        STYLE_CLASS="charging-low"
    fi
elif [ $percentage -ge 90 ]; then
    if [ "$battery_status" = "Discharging" ]; then
        STYLE_CLASS="discharging-high"
    else
        STYLE_CLASS="charging-high"
    fi
elif [ $percentage -ge 75 ]; then
    if [ "$battery_status" = "Discharging" ]; then
        STYLE_CLASS="discharging-med"
    else
        STYLE_CLASS="charging-med"
    fi
else
    STYLE_CLASS=""
fi

#---------------------------------------------------------------------
# PRINTF RETURN
#---------------------------------------------------------------------

# Return data to Waybar in JSON
printf "{\"tooltip\": \"%s %d.%dW of %d.%dW max\", \"percentage\": %d, \"class\": \"%s\"}" $battery_status $power_now_whole $power_now_frac $power_max_whole $power_max_frac $percentage $STYLE_CLASS
