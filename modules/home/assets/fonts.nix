{ pkgs, ... }: {
  home.packages = [
    pkgs.nerd-fonts.adwaita-mono
  ];

  fonts.fontconfig.enable = true;
}

