{ inputs, pkgs, ... }: {

  xdg.desktopEntries."nvim" = {
    name = "Neovim Wrapper";
    noDisplay = true;
  };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    nixpkgs.useGlobalPackages = true;
    colorschemes.gruvbox.enable = true;
    opts = {
      number = true;
      relativenumber = true;
    };
  };
}
