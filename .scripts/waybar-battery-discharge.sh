#! /bin/bash

# Get voltage from the kernel and store it in mV
voltage_now=$(( $(cat /sys/class/power_supply/BAT1/voltage_now) / 1000 ))

# Get current from the kernel and store it in mA
current_now=$(( $(cat /sys/class/power_supply/BAT1/current_now) / 1000 ))

# Calculate power in uW
power_now=$(( $voltage_now * $current_now ))

# The file to be used to store the max power as a cache (convenient way to track
# a maximum for the given system
POWER_MAX_CACHE="$HOME/.cache/.dotfiles/power_max"

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
fi

# Do some funky math to allow printing "decimal" numbers using only integers
power_now_whole=$(( $power_now / 1000000 ))
power_now_frac=$(( ( $power_now % 1000000 ) / 10000 ))

power_max_whole=$(( $power_max / 1000000 ))
power_max_frac=$(( ( $power_max % 1000000 ) / 10000 ))

# Calculate the power_now percentage relative to power_max
# Dividing the divisor by 100 gives an accurate percentage via pure integer math
percentage=$(( $power_now / $(( $power_max / 100 )) ))
printf '{"tooltip": "%d.%dW of %d.%dW max", "percentage": %s}' $power_now_whole $power_now_frac $power_max_whole $power_max_frac $percentage
