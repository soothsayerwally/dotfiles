#!/bin/bash

# Change brightness 
brightnessctl set +10%

# Get the current brightness percentage
brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)
brightness_percent=$(( brightness * 100 / max_brightness ))

# Send notification via dunst
dunstify -t 1000 -h string:x-dunst-stack-tag:brightness \
-h int:value:"$brightness_percent" "󰃠  Brightness: ${brightness_percent}%" -h string:hlcolor:#fbf1c7
