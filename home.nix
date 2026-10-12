{ pkgs, inputs, ... }:


{
  imports = [
    inputs.zen-browser.homeModules.beta
    inputs.nixvim.homeModules.nixvim
  ];

  home.username = "krishang";
  home.homeDirectory = "/home/krishang";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    git
    btop
    fzf
    ripgrep
    fd
    ptyxis	
    bitwarden-desktop
    chromium
    obsidian
    calibre
    handbrake
    vesktop
    cine
    edopro
  ];

# Git 
  programs.git = {
    enable = true;
    userName = "Krishang";
    userEmail = "krishangnayanbhagwati@gmail.com";
  };

# Zen Browser
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    nativeMessagingHosts = [
      pkgs.firefoxpwa
    ];
  };

# Fish
  programs.fish = {
    enable = true;
    
    # shell aliases
    shellAliases = {
      l = "ls -la";
      g = "git";
      v = "nvim";
    };

    # Run code on interactive shell initialization
    interactiveShellInit = ''
      set -g fish_greeting "" # Disable greeting
    '';

    # Install Fish plugins from nixpkgs
    plugins = [
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "hydro";
        src = pkgs.fishPlugins.hydro.src;
      }
      {
      	name = "pure";
	src = pkgs.fishPlugins.pure.src;
      }
      {
      	name = "done";
	src = pkgs.fishPlugins.done.src;
      }
    ];
  };

# Ptyxis (Terminal)
  programs.ptyxis = {
    enable = true;
  };
  
# GTK theme
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
#    iconTheme = {
#      name = "MoreWaita";
#      package = pkgs.morewaita-icon-theme;
#    };
  };

  # ---- NIX VIM CONFIG START ----
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    nixpkgs.useGlobalPackages = true;

    # --- Leader Key ---
    globals.mapleader = " ";
    globals.maplocalleader = " ";

    # --- Colorscheme ---
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha"; 
        integrations = {
          cmp = true;
          gitsigns = true;
          neo_tree = true;
          telescope = true;
          treesitter = true;
          which_key = true;
        };
      };
    };

    # --- Editor Options ---
    opts = {
      number = true;
      relativenumber = true; 

      # Indentation
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smartindent = true;

      # UI & Display
      termguicolors = true;
      cursorline = true;
      signcolumn = "yes"; 
      wrap = false; 
      scrolloff = 8; # Smooth scrolling 
      
      # Search Options
      ignorecase = true;
      smartcase = true;
      
      # System Integration
      clipboard = "unnamedplus"; # Sync with system clipboard 
      undofile = true; # Persistent undo 
      
      # Window Splitting
      splitright = true;
      splitbelow = true;
    };

    # --- Plugins ---
    plugins = {
      # Core UI / UX Dependencies
      web-devicons.enable = true;
      nui.enable = true;
      noice.enable = true;
      which-key.enable = true; # Keymap helper popup
      
      # Dashboard (VSCode Welcome Screen Equivalent)
      alpha = {
        enable = true;
        theme = "dashboard";
      };

      # Visual Indentation Guides
      indent-blankline.enable = true;

      # Bottom Status Bar
      lualine.enable = true;

      # Top Tabs (VSCode Tab Behavior)
      bufferline = {
        enable = true;
        settings.options = {
          diagnostics = "nvim_lsp";
          always_show_bufferline = true;
          offsets = [
            {
              filetype = "neo-tree";
              text = "File Explorer";
              highlight = "Directory";
              text_align = "left";
            }
          ];
        };
      };

      # File Explorer (Sidebar)
      neo-tree = {
        enable = true;
        enableDiagnostics = true;
        enableGitStatus = true;
        window.position = "left";
      };

      # Integrated Terminal (VSCode integrated terminal equivalent)
      toggleterm = {
        enable = true;
        settings = {
          direction = "horizontal";
          open_mapping = "[[<C-\\>]]"; # Ctrl + \ toggles terminal
        };
      };

      # Fuzzy Finder
      telescope.enable = true;

      # Syntax Highlighting
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };
      
      # Coding Utilities
      nvim-autopairs.enable = true; # Auto-closes brackets, quotes, etc.
      ts-autotag.enable = true; # Auto-closes HTML/JSX tags
      comment.enable = true; # Enables VSCode-like commenting (use 'gcc' to toggle line comment)
      todo-comments.enable = true;

      # Git Integration (VSCode GitLens & Git UI)
      gitsigns = {
        enable = true;
        settings.current_line_blame = true; # Inline git blame lens
      };
      lazygit.enable = true;

      # --- Language Server Protocol ---
      lsp = {
        enable = true;
        servers = {
          # Common web & backend stack enabled by default
          ts_ls.enable = true;        # JS/TS
          html.enable = true;         # HTML
          cssls.enable = true;        # CSS
          jsonls.enable = true;       # JSON
          pyright.enable = true;      # Python
          nixd.enable = true;         # Nix
          bashls.enable = true;       # Bash
          gopls.enable = true;        # Go
          rust_analyzer.enable = true;# Rust
          lua_ls.enable = true;       # Lua
        };
        keymaps = {
          diagnostic = {
            "[d" = "goto_prev";
            "]d" = "goto_next";
            "gl" = "open_float";
          };
          lspBuf = {
            "gd" = "definition";      # Go to Definition 
            "gr" = "references";      # Go to References 
            "gi" = "implementation";  # Go to Implementation
            "K"  = "hover";           # Show Hover Docs
            "<leader>rn" = "rename";  # Rename symbol 
            "<leader>ca" = "code_action"; # Quick Fix / Code Action 
          };
        };
      };

      # --- Autocompletion ---
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<CR>" = "cmp.mapping.confirm({ select = true })"; # Enter confirms selection
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "path"; }
          ];
        };
      };
      luasnip.enable = true; # Snippet engine backing CMP

      # --- Formatting & Linting ---
      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lsp_fallback = true;
            timeout_ms = 500;
          };
        };
      };
      lint.enable = true;
    };

    # --- Custom Keybindings ---
    keymaps = [
      # Fuzzy Finder 
      { mode = "n"; key = "<leader>p"; action = "<cmd>Telescope find_files<cr>"; options = { desc = "Find Files"; silent = true; }; }
      { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<cr>"; options = { desc = "Live Grep (Search across workspace)"; silent = true; }; }
      { mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<cr>"; options = { desc = "Find Buffers"; silent = true; }; }

      # Buffer / Tab Navigation
      { mode = "n"; key = "<S-h>"; action = "<cmd>BufferLineCyclePrev<cr>"; options = { desc = "Previous Tab"; silent = true; }; }
      { mode = "n"; key = "<S-l>"; action = "<cmd>BufferLineCycleNext<cr>"; options = { desc = "Next Tab"; silent = true; }; }
      { mode = "n"; key = "<leader>c"; action = "<cmd>bdelete<cr>"; options = { desc = "Close Tab/Buffer"; silent = true; }; }

      # Lazygit
      { mode = "n"; key = "<leader>gg"; action = "<cmd>LazyGit<cr>"; options = { desc = "LazyGit UI"; silent = true; }; }

      # Window Splitting & Navigation 
      { mode = "n"; key = "<C-h>"; action = "<C-w>h"; options = { desc = "Focus Left Split"; }; }
      { mode = "n"; key = "<C-j>"; action = "<C-w>j"; options = { desc = "Focus Lower Split"; }; }
      { mode = "n"; key = "<C-k>"; action = "<C-w>k"; options = { desc = "Focus Upper Split"; }; }
      { mode = "n"; key = "<C-l>"; action = "<C-w>l"; options = { desc = "Focus Right Split"; }; }
    ];
  };

# ---- NIX VIM CONFIG END --- #

# Firefox
  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      FirefoxLabs = false;
      HttpsOnlyMode = "force_enabled";
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
    profiles.default = {
      settings = {
        # Disable AI Features & Telemetry
        "browser.ai.control.default" = "blocked";
        "browser.ml.enable" = false;
        "toolkit.telemetry.enabled" = false;

        # Disable Search Suggestions
        "browser.urlbar.trending.featureGate" = false;
        "browser.urlbar.suggest.searches" = false;

        # Blank Page Configuration
        "browser.startup.homepage" = "about:blank";
        "browser.newtabpage.enabled" = false;
        "browser.newtabpage.activity-stream.enabled" = false;
      };
    };
  };
  
  # DCONF settings 
  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      accent-color = "slate";
      color-scheme = "prefer-dark";
      clock-show-weekday = true;
    };
    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "caps:escape" ];
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>t";
      command = "ptyxis";
      name = "open-terminal";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>e";
      command = "nautilus";
      name = "open-file-manager";
    };
  };

# Configure ssh to use https ports for git
  programs.ssh.matchBlocks = {
    "github.com" = {
      hostname = "ssh.github.com";
      port = 443;
      user = "git";
    };
  };
}
