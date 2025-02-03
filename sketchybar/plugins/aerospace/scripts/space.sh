#!/bin/zsh

source "$CONFIG_DIR/plugins/aerospace/utils.sh"
source "$CONFIG_DIR/colors.sh"

AEROSPACE="/run/current-system/sw/bin/aerospace"

update() {
  if [ "$SENDER" = "space_change" ]; then
    COLOR=$SURFACE2
    if [ "$SELECTED" = "true" ]; then
      COLOR=$ACTIVE_BG
    fi

    m = $($AEROSPACE list-monitors --focused | awk -F " " "{print $1}")
    mid=$(get_focused_monitor $m)

    sketchybar --set space.$mid.$($AEROSPACE list-workspaces --focused) \
      icon.highlight=true
  fi
}

set_space_label() {
  sketchybar --set $NAME icon="$@"
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    echo ''
  else
    $AEROSPACE workspace ${NAME#*.}
  fi
}

# echo plugin_space.sh $SENDER >> ~/aaaa
case "$SENDER" in
"mouse.clicked")
  mouse_clicked
  ;;
*)
  update
  ;;
esac
