#!/bin/bash

app_state=$(osascript -e 'if application "Spotify" is running then tell application "Spotify" to return {player state, name of current track, artist of current track}')

if [[ -n "$app_state" ]]; then
    track=$(echo $app_state | awk -F', ' '{print $2}')
    artist=$(echo $app_state | awk -F', ' '{print $3}' | sed 's/}$//')
    sketchybar --set $NAME label="$track - $artist"

    if [[ $app_state == *"playing"* ]]; then
      sketchybar --set spotify icon=󰏤
    else
      sketchybar --set spotify icon=
    fi
else
    sketchybar --set $NAME label="" icon=
fi
