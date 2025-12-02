#!/usr/bin/env bash

# Get brightness for external monitor using ddcutil
get_external_brightness() {
	ddcutil getvcp 10 | awk -F'=' '/current value/ {gsub(/[^0-9]/,"",$2); print $2}'
}

# Set brightness for external monitor using ddcutil
set_external_brightness() {
	local change="$1"
	local cur_brightness=$(get_external_brightness)
	local new_brightness=$((cur_brightness + change))
	# Clamp between 0 and 100
	if (( new_brightness < 0 )); then new_brightness=0; fi
	if (( new_brightness > 100 )); then new_brightness=100; fi
	ddcutil setvcp 10 "$new_brightness"
	notify-send -h string:x-canonical-private-synchronous:sys-notify -u low "External Monitor Brightness : ${new_brightness}%"
}

# Get brightness for internal monitor using brightnessctl
get_internal_brightness() {
	brightnessctl --device=amdgpu_bl1 g
}

# Set brightness for internal monitor using brightnessctl
set_internal_brightness() {
	local op="$1"
	brightnessctl --device=amdgpu_bl1 set "$op" && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low "Internal Monitor Brightness : $(brightnessctl --device=amdgpu_bl1 -m | awk -F, '{print substr($4, 0, length($4)-1)}')%"
}

# Main logic
get_focused_monitor() {
	MONITOR_NAME=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .name')
	echo "$MONITOR_NAME"
}

get_backlight() {
	FOCUSED_MONITOR=$(get_focused_monitor)
	if [[ "$FOCUSED_MONITOR" == "eDP-1" ]]; then
		get_internal_brightness
	else
		get_external_brightness
	fi
}

inc_backlight() {
	FOCUSED_MONITOR=$(get_focused_monitor)
	if [[ "$FOCUSED_MONITOR" == "eDP-1" ]]; then
		set_internal_brightness "+5%"
	else
		set_external_brightness 5
	fi
}

dec_backlight() {
	FOCUSED_MONITOR=$(get_focused_monitor)
	if [[ "$FOCUSED_MONITOR" == "eDP-1" ]]; then
		set_internal_brightness "5%-"
	else
		set_external_brightness -5
	fi
}

# # Zero brightness
# zero_backlight() {
# 	DEV=$(get_device_name "$(get_focused_monitor)")
# 	brightnessctl --device="$DEV" set 0%
# }

# # Full brightness
# full_backlight() {
# 	DEV=$(get_device_name "$(get_focused_monitor)")
# 	brightnessctl --device="$DEV" set 100%
# }

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	get_backlight
elif [[ "$1" == "--inc" ]]; then
	inc_backlight
elif [[ "$1" == "--dec" ]]; then
	dec_backlight
else
	get_backlight
fi
