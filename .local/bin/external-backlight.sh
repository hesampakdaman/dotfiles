#!/bin/bash

# setvcp arguments are + N to increase N or - N to decrease
# $* joins all arguments (e.g. + and 10) into a single string
ddcutil setvcp 10 $* --noverify

# Get the new value to show in the OSD
# --terse format: VCP 10 C 50 100 (where 50 is current, 100 is max)
current=$(ddcutil getvcp 10 --terse | awk '{print $4}')

# Trigger SwayOSD to show the bar
swayosd-client --brightness "$current"
