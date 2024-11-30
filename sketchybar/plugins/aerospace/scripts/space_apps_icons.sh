get_apps_icons() {
  apps=$(aerospace list-windows --workspace "$@" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

  icon_strip=""
  if [ "${apps}" != "" ]; then
    while read -r app; do
      __icon_map "${app}"
      icon_strip+=" ${icon_result}"
    done <<<"${apps}"
  else
    icon_strip=" —"
  fi

  echo "$icon_strip"
}
