#!/bin/bash

# Change brightness 
brightnessctl set +5%

sleep 0.1

info=$(brightnessctl info -m)
brightness_percent=$(echo $info | cut -d',' -f4)

# Send notification via dunst
dunstify -t 1000 -h string:x-dunst-stack-tag:brightness \
-h int:value:"$brightness_percent" "󰃠  Brightness: ${brightness_percent}" -h string:hlcolor:#fbf1c7
