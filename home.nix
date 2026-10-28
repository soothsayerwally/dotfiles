{ pkgs, inputs, lib, ... }:


{
  imports = [
    inputs.zen-browser.homeModules.beta
    inputs.reaper-flake.homeModules.reaper
  ];

  home.username = "krishang";
  home.homeDirectory = "/home/krishang";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    ripgrep
    fd
    lazygit
    yt-dlp
    bat

    bitwarden-desktop
    chromium
    obsidian
    calibre
    handbrake
    vesktop
    cine
    edopro
    gimp
    krita
    pcsx2
    super-productivity
    (bottles.override { removeWarningPopup = true; })
  ];


  # nh: nix helper
  programs.nh = {
    enable = true;
    clean.enable = false; # handled by nix.gc in configuration.nix
    flake = "/home/krishang/dotfiles";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # zoxide: cooler cd 
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ]; # Replaces cd directly with zoxide ('cdi` for interactive fzf jump)
  };

  # atuin: fuzzy shell history
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    flags = [ "--disable-up-arrow" ]; 
    settings = {
      auto_sync = false; # lets keep it local 
      search_mode = "fuzzy";
      filter_mode_shell_up_key_binding = "directory";
      style = "compact";
      inline_height = 20;
    };
  };

  # yazi: terminal file manager
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y"; # Press `y` to browse, `q` to quit AND change working directory to where you landed!
    settings = {
      manager = {
        show_hidden = false;
        sort_by = "natural";
        sort_dir_first = true;
      };
    };
    theme = {
      flavor = {
        dark = "kanagawa-wave";
      };
    };
  };

  # bat + bat-Extras 
  programs.bat = {
    enable = true;
    config = {
      theme = "ansi"; 
      style = "numbers,changes,header";
    };
    extraPackages = with pkgs.bat-extras; [
      batman   
      batgrep  
      batdiff  
    ];
  };
    
  # btop: cooler htop
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "kanagawa";
      vim_keys = true;
    };
  };

  # Git 
  programs.git = {
    enable = true;
    settings.user = {
      name = "Krishang";
      email = "krishangnayanbhagwati@gmail.com";
    };
  };

  # Zen Browser
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    nativeMessagingHosts = [
      pkgs.firefoxpwa
    ];
  };

  # Zellij 
  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    exitShellOnExit = false;

  settings = {
    theme = "kanagawa";
    default_layout = "default";
    pane_frame_style = "full";
    show_startup_tips = false;
  };
};

  # Fish
  programs.fish = {
    enable = true;
    
    # shell aliases
    shellAliases = {
      l = "ls -la";
      v = "nvim";
      cat = "bat --paging=never";
      catp = "bat --plain --paging=never";
      man = "batman";
      bgrep = "batgrep";
    };

    # shell abbreviations
    shellAbbrs = {
      g = "git";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gs = "git status -sb";
      lzg = "lazygit";
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
      	name = "pure";
	      src = pkgs.fishPlugins.pure.src;
      }
      {
      	name = "done";
	      src = pkgs.fishPlugins.done.src;
      }
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
      {
        name = "sponge"; # keep failed commands out of history
        src = pkgs.fishPlugins.sponge.src;
      }
    ];
  };

  # eza
  programs.eza = {
    enable = true;
    enableFishIntegration = true; # Automatically creates ls, ll, la, lla, lt
    icons = "auto";
    git = true;
    extraOptions = [
      "--group-directories-first"
      "--color=always"
    ];
  };

  # Ghostty (Terminal)
    programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    installBatSyntax = true; 

    settings = {
      theme = "Kanagawa Wave";
      font-family = "AdwaitaMono Nerd Font";
      font-size = 10;

      window-decoration = true;
      gtk-titlebar = true;
      gtk-single-instance = true; # faster window spawning 
      window-padding-x = 8;
      window-padding-y = 8;

      copy-on-select = "clipboard";
      confirm-close-surface = false;
      mouse-hide-while-typing = true;
      window-save-state = "always";
    };
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

  # Reaper
  programs.reaper = {
    enable = true;

    packages = with pkgs; [
      freetype 
      fontconfig
    ];
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

    "org/gnome/desktop/peripherals/keyboard" = {
      delay = lib.hm.gvariant.mkUint32 200;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>t";
      command = "ghostty";
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
