#!/usr/bin/env bash

source "$HOME/.config/sketchybar/icons.sh"
source "$HOME/.config/sketchybar/colors.sh"

cpu=(
  background.padding_left=0
  label.font="$FONT:Heavy:12"
  label.color="$TEXT"
  icon="$CPU"
  icon.color="$TEAL"
  update_freq=60
  script="$PLUGIN_DIR/stats/scripts/cpu.sh"
)

memory=(
  background.padding_left=0
  label.font="$FONT:Heavy:12"
  label.color="$TEXT"
  icon="$MEMORY"
  icon.font="$NERD_FONT:Bold:16.0"
  icon.color="$GREEN"
  update_freq=15
  script="$PLUGIN_DIR/stats/scripts/memory.sh"
)

disk=(
  background.padding_left=0
  label.font="$FONT:Heavy:12"
  label.color="$TEXT"
  icon="$DISK"
  icon.color="$MAROON"
  update_freq=60
  script="$PLUGIN_DIR/stats/scripts/disk.sh"
)

sketchybar --add item stats.cpu right                       \
           --add item stats.memory right                    \
           --add item stats.disk right                      \
           --set stats.cpu "${cpu[@]}"                      \
           --set stats.disk "${disk[@]}"                    \
           --set stats.memory "${memory[@]}"

stats_bracket=(
  background.color="$SURFACE0"
  background.border_color="$SURFACE1"
  background.border_width=0
  background.padding_right=5
  background.drawing=on
)

sketchybar --add bracket stats '/stats\..*/' \
           --set stats "${stats_bracket[@]}"