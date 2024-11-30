#!/bin/bash
# Slack notifications
sketchybar --add item slack right                              \
           --set slack   update_freq=180                       \
                         script="$PLUGIN_DIR/slack.sh"         \
                         background.padding_left=15            \
                         icon.font.size=18                     \
           --subscribe slack system_woke
