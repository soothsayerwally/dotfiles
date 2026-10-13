{ pkgs, lib, ... }:

{
  vim = {

    # Theme
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
    };

    # Options
    options = {
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true; # Convert tabs to spaces
      autoindent = true;
      smartindent = true;
    };

    # Plugins
    statusline.lualine.enable = true;
    dashboard.alpha.enable = true;

    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    filetree.neo-tree.enable = true;
    binds.whichKey.enable = true;
    git.gitsigns.enable = true;
    autopairs.nvim-autopairs.enable = true;

    treesitter.context.enable = true;
    
    # LSP 
    languages = {
      enableTreesitter = true;
      enableFormat = true;

      nix = {
        enable = true;
        lsp.enable = true;
      };
      python = {
        enable = true;
        lsp.enable = true;
      };
      rust = {
        enable = true;
        lsp.enable = true;
      };
    };

    # Shortcuts
    globals.mapleader = " ";

    maps.normal = {
      # Toggle Neotree
      "<leader>e" = {
        action = "<cmd>Neotree toggle<CR>";
        desc = "Toggle File Explorer";
      };

      # Telescope 
      "<leader>ff" = {
        action = "<cmd>Telescope find_files<CR>";
        desc = "Find Files";
      };
      "<leader>fg" = {
        action = "<cmd>Telescope live_grep<CR>";
        desc = "Search Text in Project";
      };

      # LSP 
      "gd" = {
        action = "<cmd>Telescope lsp-definitions<CR>";
        desc = "Go to Definition";
      };
      "gr" = {
        action = "<cmd>Telescope lsp-references<CR>";
        desc = "Find References";
      };
      "<leader>rn" = {
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        desc = "Rename Variable";
      };
    };
  };
}

