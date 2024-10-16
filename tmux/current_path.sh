#!/bin/sh
awk -F '/' '{if(NF > 4){print ""$(NF-1)"/"$(NF)}else{print}}' </dev/stdin
