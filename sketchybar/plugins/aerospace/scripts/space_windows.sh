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
source "$CONFIG_DIR/plugins/aerospace/scripts/space_apps_icons.sh"

reload_workspace_icon() {
  icon_strip=$(get_apps_icons "$@")
  sketchybar --set space.$@ label="$icon_strip" icon="$@"
}

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  echo "space_windows.sh, workspace $@"

  # current workspace space border color
  sketchybar --set space.$AEROSPACE_FOCUSED_WORKSPACE icon.highlight=true \
    label.highlight=true

  # prev workspace space border color
  sketchybar --set space.$AEROSPACE_PREV_WORKSPACE \
    icon.highlight=false \
    label.highlight=false

  reload_workspace_icon "$AEROSPACE_PREV_WORKSPACE"
  reload_workspace_icon "$AEROSPACE_FOCUSED_WORKSPACE"

  AEROSPACE_FOCUSED_MONITOR=$(aerospace list-monitors --focused | awk '{print $1}')
  AEROSAPCE_WORKSPACE_FOCUSED_MONITOR=$(aerospace list-workspaces --monitor focused --empty no)

  # focused 된 모니터에 space 상태 보이게 설정
  for i in $AEROSAPCE_WORKSPACE_FOCUSED_MONITOR; do
    sketchybar --set space.$i display=$AEROSPACE_FOCUSED_MONITOR
  done

  sketchybar --set space.$AEROSPACE_FOCUSED_WORKSPACE display=$AEROSPACE_FOCUSED_MONITOR
fi
