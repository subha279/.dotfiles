#!/bin/sh

DIR="$HOME/Wallpaper/"
SCRIPTS="$HOME/Scripts/"

PICS=($(find ${DIR} -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \)))
RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}

# Transition
FPS=30
TYPE="any"
DURATION=2
SWWW_TRANSITION="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"

swww query || swww init && swww img ${RANDOMPICS} $SWWW_TRANSITION
#&& wal -i ${RANDOMPICS}
