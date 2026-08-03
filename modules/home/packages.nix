{ pkgs, ... }: {
  # User-specific packages
  home.packages = with pkgs; [
    fastfetch
    ripgrep
    fzf
    obsidian
    superfile
    tree
    discord
    bitwarden-desktop
    brightnessctl
    varia
    amberol
    nicotine-plus
  ];
}
  
