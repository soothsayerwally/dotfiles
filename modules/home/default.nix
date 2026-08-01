
{ pkgs, ... }: {
  imports = [
    ./programs/neovim.nix
    ./programs/ghostty.nix
    ./programs/bash.nix
    ./programs/cups.nix
    ./programs/git.nix
    ./programs/firefox.nix
    ./gnome/gnome-dconf.nix
    ./gnome/gtk-theme.nix
    ./packages.nix
  ];

  home.username = "krishang";
  home.homeDirectory = "/home/krishang";

  # DO NOT CHANGE ABORT ABORT
  home.stateVersion = "26.05";
}
