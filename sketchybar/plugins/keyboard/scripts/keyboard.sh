#!/bin/bash

# this is junk and ugly, I know
LAYOUT="$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "KeyboardLayout Name" | cut -c 33- | rev | cut -c 2- | rev)"

# specify short layouts individually.
case "$LAYOUT" in
"\"U.S.\"") SHORT_LAYOUT="US" ;;
"RussianWin") SHORT_LAYOUT="RU" ;;
"\"Colemak DH ANSI\"") SHORT_LAYOUT="CO" ;;
"\"Graphite\"") SHORT_LAYOUT="GR" ;;
*) SHORT_LAYOUT="한" ;;
esac

sketchybar --set keyboard label="$SHORT_LAYOUT"
