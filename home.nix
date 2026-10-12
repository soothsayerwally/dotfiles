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
    ripgrep
    fd
    ptyxis	
    bitwarden-desktop
    chromium
    obsidian
    calibre
    vesktop
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
    iconTheme = {
      name = "MoreWaita";
      package = pkgs.morewaita-icon-theme;
    };
  };

# Nixvim 
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    nixpkgs.useGlobalPackages = true;
    colorschemes.everforest.enable = true;

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
