#!/bin/bash

# Define your username
USER_NAME="hesam"
USER_ID=$(id -u $USER_NAME)

# Find the Hyprland signature (stored in /tmp/hypr/ or /run/user/ID/hypr/)
# This checks the most recent Hyprland session directory
HYPR_SIG=$(ls -t /run/user/$USER_ID/hypr/ | head -n 1)

export HYPRLAND_INSTANCE_SIGNATURE="$HYPR_SIG"
export XDG_RUNTIME_DIR="/run/user/$USER_ID"

LID_STATE=$(cat /proc/acpi/button/lid/*/state 2>/dev/null)

if echo "$LID_STATE" | grep -q closed; then
    sudo -u $USER_NAME HYPRLAND_INSTANCE_SIGNATURE=$HYPR_SIG hyprctl keyword monitor "eDP-1,disable"
else
    sudo -u $USER_NAME HYPRLAND_INSTANCE_SIGNATURE=$HYPR_SIG hyprctl keyword monitor "eDP-1,2560x1600@60,0x0,1"
fi
