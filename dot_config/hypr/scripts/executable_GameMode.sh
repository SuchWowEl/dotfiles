#!/bin/bash
# In courtesy of JaKooLit
## /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Game Mode. Turning off all animations

notif="$HOME/.config/swaync/images/bell.png"
SCRIPTSDIR="$HOME/.config/hypr/scripts"


HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==2{print $2}')
if [ "$HYPRGAMEMODE" = 1 ] ; then
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur:passes 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0"
    # swww kill 
    dunstify -h string:x-dunst-stack-tag:gAmIngG -u low "gamemode enabled. All animations off"
    exit
else
	# swww init && swww img "$HOME/.config/rofi/.current_wallpaper"
	# sleep 0.1
	# ${SCRIPTSDIR}/PywalSwww.sh
	# sleep 0.5
	# ${SCRIPTSDIR}/Refresh.sh	  
    hyprctl --batch "\
        keyword animations:enabled yes;\
        keyword decoration:drop_shadow yes;\
        keyword decoration:blur:passes 3;\
        keyword general:gaps_in 5;\
        keyword general:gaps_out 20;\
        keyword general:border_size 2;\
        keyword decoration:rounding 10"
    dunstify -h string:x-dunst-stack-tag:gAmIngG -u low "gamemode disabled. All animations normal"
    exit
fi
hyprctl reload
