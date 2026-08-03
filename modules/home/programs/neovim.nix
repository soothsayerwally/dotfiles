{ inputs, pkgs, ... }: {

  xdg.desktopEntries."nvim" = {
    name = "Neovim Wrapper";
    noDisplay = true;
  };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    nixpkgs.useGlobalPackages = true;
    colorschemes.gruvbox-material.enable = true;

    plugins.lualine.enable = true;
    plugins.mini-pairs.enable = true;
    plugins.ts-comments.enable = true;
    plugins.mini-ai.enable = true;
    plugins.which-key.enable = true;
    plugins.todo-comments.enable = true;
    plugins.conform-nvim.enable = true;
    plugins.lint.enable = true;
    plugins.treesitter.enable = true;
    plugins.bufferline.enable = true;
    plugins.noice.enable = true;
    plugins.mini-icons.enable = true;
    plugins.nui.enable = true;
    plugins.telescope.enable = true;

    opts = {
      number = true;
      relativenumber = true;
    };
  };
}
