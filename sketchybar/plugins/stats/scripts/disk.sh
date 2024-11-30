#!/usr/bin/env bash
#disk.sh

sketchybar -m --set stats.disk label="$(df -H | grep -E '^(/dev/disk3s5).' | awk '{ printf ("%s\n", $5) }')"
