#!/usr/bin/env bash

battery_details=(
	background.corner_radius=4
	background.padding_left=0
	background.padding_right=10
	icon.background.height=2
	icon.background.y_offset=-50
)

sketchybar -m --add item    battery right 		                               \
              --set battery update_freq=1 			                             \
                            background.padding_left=10                       \
                            script="$PLUGIN_DIR/battery/scripts/battery.sh"  \
              --subscribe   battery           mouse.entered                  \
                                              mouse.exited                   \
                                              mouse.exited.global            \
              --add         item              battery.details popup.battery  \
              --set         battery.details   "${battery_details[@]}"
