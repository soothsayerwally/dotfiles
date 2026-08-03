{ pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./users.nix
    ../../modules/system/core.nix
    ../../modules/system/gnome-desktop.nix
    ../../modules/system/gnome-extensions.nix
    ../../modules/system/programs/syncthing.nix
    ../../modules/system/programs/steam.nix
    ../../modules/system/programs/distrobox.nix
  ];

  networking.hostName = "reverie";
  time.timeZone = "Asia/Kolkata";

  # Locale
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };
  
  # DO NOT CHANGE ABORT ABORT
  system.stateVersion = "26.05";
}
