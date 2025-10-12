#! /bin/zsh

# Author: sharpicx 

volume="$(pamixer --get-volume)"

notify_user() {
    if [[ "$(pamixer --get-volume-human | tr -d '[:space:]')" == "muted" ]]; then
        notify-send -h string:x-dunst-stack-tag:volume_notif -u low "Volume: Muted"
    else
        notify-send -h int:value:"$(pamixer --get-volume-human)" -h string:x-dunst-stack-tag:volume_notif -u low "Volume: $(pamixer --get-volume-human)"
    fi
}

case $1 in
        up)
                pamixer -i 5
                # volume="$(pamixer --get-volume)"
                # dunstify "VOLUME" "Volume get increasing to $volume%" -h int:value:$volume -h string:x-dunst-stack-tag:msgTag -i audio-volume-high 
                notify_user
                canberra-gtk-play -i audio-volume-change -d "changevolume"
                ;;
        down)
                pamixer -d 5
                # volume="$(pamixer --get-volume)"
                # dunstify "VOLUME" "Volume get decreasing to $volume%" -h int:value:$volume -h string:x-dunst-stack-tag:msgTag -i audio-volume-low 
                notify_user
                canberra-gtk-play -i audio-volume-change -d "changevolume"
                ;;
        mute)
                pamixer -t
                muted="$(pamixer --get-mute)"
                # if $muted ; then
                #         dunstify "VOLUME" "Volume is getting muted!" -i audio-volume-muted-blocking -u low
                # else
                #         dunstify "VOLUME" "Volume aint muted!" -i audio-volume-high -u low
                #         canberra-gtk-play -i audio-volume-change 
                # fi
                notify_user
                ;;
esac
