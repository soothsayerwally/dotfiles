#!/bin/sh

# Make sure you're root
if [ "$(id -u)" -ne 0 ]; then
    echo "Run this script as root!"
    exit 1
fi



# Core system
xbps-install -Sy base-system base-devel linux make git curl wget sudo linux-firmware

# X11 and related tools
xbps-install -y xinit xf86-input-libinput xrandr xrdb xsetroot xclip xauth \
    xinput xwininfo xdpyinfo xprop xcursor-themes xorg-fonts

# Compositor, notification daemon, background setter, screenshots
xbps-install -y picom dunst feh scrot 

# Networking
xbps-install -y iwd curl socat

# Bluetooth
xbps-install -y bluez bluetuith libspa-bluetooth

# Audio
xbps-install -y pipewire alsa-pipewire alsa-ucm-conf pavucontrol sof-firmware alsa-plugins-pulseaudio sof-tools

# Fonts
xbps-install -y noto-fonts-ttf noto-fonts-cjk noto-fonts-emoji nerd-fonts-symbols-ttf

# Stuff you need for suckless software
xbps-install -y libX11-devel libXft-devel libXinerama-devel imlib2-devel libXrandr-devel \
    fontconfig-devel freetype-devel

# Useful CLI tools
xbps-install -y vim ranger tmux htop fastfetch fd ripgrep stow unclutter dialog p7zip

# Time sync 
xbps-install -y chrony

# Power saving 
xbps-install -y tlp

# Browsers & media
xbps-install -y firefox mpv yt-dlp

# Optional GUI utilities
xbps-install -y brightnessctl redshift

# Stuff
xbps-install -y emacs-x11 elogind polkit

# Final note
echo "Done! Reboot recommended. Don't forget to enable services (tlp, iwd, chronyd)."

