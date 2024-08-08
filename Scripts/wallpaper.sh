#!/bin/sh

wall=$(find /home/subha/Wallpaper -type f -name "*jpg" -o -name "*png" -o -name "*gif" | shuf -n 1)

swww img $wall

wal -c

wal -i $wall
