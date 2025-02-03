#!/bin/bash

sketchybar --add item spotify right \
  --set spotify \
  update_freq=5 \
  icon= \
  icon.color=0xff1db954 \
  label.color=0xffffffff \
  click_script="osascript -e 'tell application \"Spotify\" to playpause'" \
  script="$(
    cat <<-EOF
                    app_state=\$(osascript -e 'if application "Spotify" is running then tell application "Spotify" to return {player state, name of current track, artist of current track}')
                    
                    track=\$(echo \$app_state | awk -F', ' '{print \$2}')
                    artist=\$(echo \$app_state | awk -F', ' '{print \$3}' | sed 's/}$//')
                    sketchybar --set \$NAME label="\$track - \$artist"

                    if [[ \$app_state == *"playing"* ]]; then
                      sketchybar --set spotify icon=󰏤
                    else
                      sketchybar --set spotify icon=
                    fi
EOF
  )"
