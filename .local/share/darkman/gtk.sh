#!/bin/sh

case "$1" in
  dark)
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    ;;
  light)
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    ;;
  *)
    echo "Usage: $0 {dark|light}"
    exit 1
    ;;
esac
