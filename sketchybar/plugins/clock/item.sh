#!/bin/bash

clock=(
  background.padding_left=0
  background.padding_right=2
  update_freq=10
  icon=""
  script="$PLUGIN_DIR/clock/scripts/clock.sh"
)

sketchybar  --add item clock right            \
            --set clock "${clock[@]}"

