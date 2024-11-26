#! /bin/bash

# https://github.com/SherLock707/waybar-cava (e8856de)

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# creating "dictionary" to replace char with bar
i=0
while [ $i -lt ${#bar} ]
do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i=i+1))
done

# write cava config
config_file="/tmp/polybar_cava_config"
echo "
[general]
bars = 20
stereo = false
autosens = 1
lower_cutoff_freq = 50
higher_cutoff_freq = 20000
reverse = false
method = pulse
monstercat = true
waves = false
noise_reduction = 0.5
sleep_timer = 1

[output]
method = raw
channels = mono
mono_option = average
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
" > $config_file

# read stdout from cava
cava -p $config_file | while read -r line; do
    echo $line | sed $dict
done
