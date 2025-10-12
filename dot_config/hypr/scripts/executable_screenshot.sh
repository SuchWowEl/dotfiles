#!/bin/bash
#lazy screenshot script

grim - | tee ~/Pictures/Screenshots/"$(date +%Y-%m-%d-%H-%M-%S-%3N)".png | wl-copy

dunstify -h string:x-dunst-stack-tag:SCreEnshOt -u low "Screenshot taken"

