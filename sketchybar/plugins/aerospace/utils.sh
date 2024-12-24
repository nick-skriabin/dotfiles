#!/bin/zsh

get_focused_monitor() {
  # echo $(($1 == 1 ? $1 + 2 : $1 - 1)) # hack for aerospace/sketchybar
  echo $1
}
