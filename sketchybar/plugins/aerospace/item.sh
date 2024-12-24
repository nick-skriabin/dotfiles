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
      icon.color=$OVERLAY0
      icon.highlight_color=$TEXT
      icon.font="$FONT:Heavy:14.0"
      icon.padding_left=6
      icon.padding_right=6
      display=$mid \
      padding_left=2
      padding_right=2
      label.padding_right=20
      label.color=$SUBTEXT1
      label.highlight_color=$RED
      label.font="$ICON_FONT_SETTINGS"
      background.color=$SURFACE1
      label.y_offset=-1
      update_freq=0.5
      script="$PLUGIN_DIR/aerospace/scripts/space.sh"
    )
    key=space.$mid.$sid

    sketchybar --add space $key left \
      --set $key "${space[@]}" \
      --subscribe $key mouse.clicked

    icon_strip=$(get_apps_icons $sid)

    sketchybar --set $key label="$icon_strip" icon="$sid"

    if [ "$sid" = "$focused_workspace" ]; then
      sketchybar --set $key \
        icon.highlight=true \
        label.highlight=true
    fi
  done
done

space_creator=(
  icon.drawing=off
  label.drawing=off
  display=active
  script="$PLUGIN_DIR/aerospace/scripts/space_windows.sh"
)

sketchybar --add item space_creator left \
  --set space_creator "${space_creator[@]}" \
  --subscribe space_creator aerospace_workspace_change
