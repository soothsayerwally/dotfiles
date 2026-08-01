{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  xdg.desktopEntries."nvim" = {
    name = "Neovim Wrapper";
    noDisplay = true;
  };
}
