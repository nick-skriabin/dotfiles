#!/usr/bin/env bash
#ram.sh

sketchybar -m --set stats.memory label="$(memory_pressure | grep "System-wide memory free percentage:" | awk '{ printf("%2.0f\n", 100-$5"%") }')%"
