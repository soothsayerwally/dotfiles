#!/bin/sh

case $(printf "%s\n" "Shut down" "Reboot" "Lock" | tofi -c ~/.config/tofi/configEsc) in
	"Shut down")
		systemctl poweroff
		;;
	"Reboot")
		systemctl reboot
		;;
	"Lock")
		hyprlock
		;;
esac
