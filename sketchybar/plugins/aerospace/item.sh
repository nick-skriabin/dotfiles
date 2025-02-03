#!/bin/zsh
source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icon_map.sh"
source "$CONFIG_DIR/plugins/aerospace/scripts/space_apps_icons.sh"
source "$CONFIG_DIR/plugins/aerospace/utils.sh"

CURRENT_FONT="sketchybar-app-font"
ICON_FONT_SETTINGS="$CURRENT_FONT:Regular:16.0"
AEROSPACE="/run/current-system/sw/bin/aerospace"

sketchybar --add event aerospace_workspace_change

for m in $($AEROSPACE list-monitors | awk '{print $1}'); do
  focused_workspace=$($AEROSPACE list-workspaces --monitor $m focused --visible)

  for i in $($AEROSPACE list-workspaces --monitor $m); do
    sid=$i
    mid=$(get_focused_monitor $m)

    space=(
      space="$sid"
      icon="$sid"
      icon.color=$TEXT
      icon.highlight_color=$RED
      icon.font="$FONT:Heavy:14.0"
      icon.padding_left=12
      icon.padding_right=6
      display=$mid \
      padding_left=0
      padding_right=6
      # background.color=$SURFACE2
      update_freq=0.1
      script="$PLUGIN_DIR/aerospace/scripts/space.sh"
    )
    key="space.$mid.$sid"

    sketchybar --add space $key left \
      --set $key "${space[@]}" \
      --subscribe $key mouse.clicked

    sketchybar --set $key icon="$sid"

    if [ "$sid" = "$focused_workspace" ]; then
      sketchybar --set $key \
        icon.highlight=true
    fi
  done
done

space_creator=(
  icon.drawing=off
  script="$PLUGIN_DIR/aerospace/scripts/space_windows.sh"
)

sketchybar --add item space_creator left \
  --set space_creator "${space_creator[@]}" \
  --subscribe space_creator aerospace_workspace_change
