#!/bin/bash

# List of applications to install
applications=(
  git
  firefox
  ranger
  waybar
  hyprland
  nwg-look
  gammastep
  kitty
  dunst
  kvantum
  neovim
  tmux
  htop
  curl
  wget
  chezmoi
)

# List of applications to install via yay
yay_apps=(
  tofi
		
)

# Function to install yay
install_yay() {
  echo "Installing yay (AUR helper)..."
  if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay || exit
    makepkg -si --noconfirm
    cd - || exit
    rm -rf /tmp/yay
  else
    echo "yay is already installed."
  fi
}

# Check if chezmoi is installed
if ! command -v chezmoi &> /dev/null; then
  echo "chezmoi is not installed. Installing necessary applications first..."
  sudo pacman -Syu --needed --noconfirm "${pacman_apps[@]}"
  install_yay
  echo "chezmoi installed. Initializing and applying dotfiles..."
  chezmoi init --apply git@github.com:soothsayerwally/dotfiles.git
else
  echo "chezmoi is already installed. Applying dotfiles..."
  chezmoi apply
fi

# Install additional yay applications after chezmoi setup
echo "Installing additional yay applications..."
yay -S --needed --noconfirm "${yay_apps[@]}"

echo "Setup complete!"


