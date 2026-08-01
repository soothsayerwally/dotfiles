{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    settings = {};
  };
}
