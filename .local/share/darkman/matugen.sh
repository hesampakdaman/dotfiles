#!/bin/sh

STATE_FILE="$HOME/.local/state/wallpaper_path"

# if the file doesn't exist, exit immediately
[ ! -f "$STATE_FILE" ] && exit 0

# read the path and strip any trailing newlines
WAL=$(tr -d '\n\r' < "$STATE_FILE")

# if the file is empty, exit
[ -z "$WAL" ] && exit 0

# run matugen using the mode passed by darkman inside $1 (light or dark)
matugen image "$WAL" -m "$1" --source-color-index 0
