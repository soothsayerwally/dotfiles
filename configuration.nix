{ pkgs, ... }: {
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

  # Bootloader & Kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # GNOME Desktop
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Audio (Pipewire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Networking & Printing
  networking.networkmanager.enable = true;
  services.printing.enable = true;

  # Define User
  users.users.krishang = {
    isNormalUser = true;
    description = "Krishang";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # System level apps
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wl-clipboard
    gnome-tweaks
  ];

  # Gnome stuff
  environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs epiphany totem gnome-music xterm ];
  hardware.sensor.iio.enable = true;
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05";
}
