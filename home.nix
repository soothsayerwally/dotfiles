{ pkgs, inputs, lib, ... }:


{
  imports = [
    inputs.zen-browser.homeModules.beta
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
    yt-dlp

    ptyxis	

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
  ];

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
    exitShellOnExit = true;


  settings = {
    theme = "catppuccin-mocha";
    # default_layout = "compact";
  };
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
