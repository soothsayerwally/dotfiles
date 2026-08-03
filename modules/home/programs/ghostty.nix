{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    settings = {
      theme = "Gruvbox Material Dark";
      command = "${pkgs.fish}/bin/fish";
      font-family = "AdwaitaMono Nerd Font";
    };
  };
}
