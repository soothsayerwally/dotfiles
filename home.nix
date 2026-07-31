{ pkgs, ... }: {
  home.username = "krishang";
  home.homeDirectory = "/home/krishang";

  # User-specific packages
  home.packages = with pkgs; [
    neovim
    fastfetch
    ripgrep
    htop
    ghostty
  ];

  # Basic Git configuration managed by Home Manager
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Krishang";
        email = "krishangnayanbhagawati@gmail.com";
      };
    };
  };

  # Bash shell setup
  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles/#reverie";
      v = "nvim";
    };
  };

  # Do NOT change this after initial installation!
  home.stateVersion = "26.05";

  # GNOME stuff
  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      accent-color = "slate";
    };
    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "caps:escape" ];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
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
}

