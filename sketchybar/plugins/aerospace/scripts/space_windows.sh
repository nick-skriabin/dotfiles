#!/bin/sh

echo AEROSPACE_PREV_WORKSPACE: $AEROSPACE_PREV_WORKSPACE, \
  AEROSPACE_FOCUSED_WORKSPACE: $AEROSPACE_FOCUSED_WORKSPACE \
  SELECTED: $SELECTED \
  BG2: $BG2 \
  INFO: $INFO \
  SENDER: $SENDER \
  NAME: $NAME \
  >>~/aaaa

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icon_map.sh"
# source "$CONFIG_DIR/plugins/aerospace/scripts/space_apps_icons.sh"
source "$CONFIG_DIR/plugins/aerospace/utils.sh"

AEROSPACE="/run/current-system/sw/bin/aerospace"
# focused_monitor=$($AEROSPACE list-monitors --focused | awk '{print $1}')
focused_monitor=1

reload_workspace_icon() {
  mid=$(get_focused_monitor $focused_monitor)
  sketchybar --set "space.$mid.$@" icon="$@"
}

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  echo "space_windows.sh, workspace $@"

  mid=$(get_focused_monitor $focused_monitor)

  # current workspace space border color
  sketchybar --set space.$mid.$AEROSPACE_FOCUSED_WORKSPACE icon.highlight=true \
    icon.highlight=true

  # prev workspace space border color
  sketchybar --set space.$mid.$AEROSPACE_PREV_WORKSPACE \
    icon.highlight=false

  reload_workspace_icon "$AEROSPACE_PREV_WORKSPACE"
  reload_workspace_icon "$AEROSPACE_FOCUSED_WORKSPACE"

  AEROSPACE_FOCUSED_WORKSPACE=$($AEROSPACE list-workspaces --monitor focused --empty no)

  # focused 된 모니터에 space 상태 보이게 설정
  for i in $AEROSPACE_FOCUSED_WORKSPACE; do
    sketchybar --set space.$mid.$i display=$mid
  done

  sketchybar --set space.$mid.$AEROSPACE_FOCUSED_WORKSPACE display=$mid
fi
