{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    settings = {
      theme = "Gruvbox Material Dark";
      font-family = "AdwaitaMono Nerd Font";
    };
  };
}
