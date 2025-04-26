#!/bin/sh

# Simple dmenu power menu for DWM + Void Linux (musl)
choice=$(printf "Lock\nReboot\nShutdown" | dmenu -i -fn "TerminessNerdFont:size=12" -nb "#282828" -nf "#fbf1c7" -sb "#d65d0e" -sf "#fbf1c7" -p "Choose:")

case "$choice" in
    Lock)
        slock
        ;;
    Reboot)
        loginctl reboot
        ;;
    Shutdown)
        loginctl poweroff
        ;;
    *)
        ;;
esac

