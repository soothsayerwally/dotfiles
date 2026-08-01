{ pkgs, ... }: {
  imports = [
    ./programs/neovim.nix
    ./programs/ghostty.nix
    ./programs/bash.nix
    ./programs/cups.nix
    ./programs/git.nix
    ./programs/firefox.nix
    ./desktop/gnome-dconf.nix
    ./desktop/gtk-theme.nix
  ];

  # User-specific packages
  home.packages = with pkgs; [
    fastfetch
    ripgrep
  ];

  home.username = "krishang";
  home.homeDirectory = "/home/krishang";

  # DO NOT CHANGE ABORT ABORT
  home.stateVersion = "26.05";
}
