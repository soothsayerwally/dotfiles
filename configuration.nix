{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix 
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata"; 
  i18n.defaultLocale = "en_US.UTF-8";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Sensor support (auto-rotate)
  hardware.sensor.iio.enable = true;
  
  # Enable TRIM
  services.fstrim.enable = true;
  services.fstrim.interval = "weekly";

  # Enable GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  # Exclude default GNOME bloat 
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    epiphany
    gnome-user-docs
    gnome-console
    xterm
    gnome-music
    yelp
    showtime
  ];

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.adwaita-mono
  ];

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.krishang = {
    isNormalUser = true;
    description = "Krishang";
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "12345"; # Change this immediately after login
  };

  # Enable cloudflare-warp service
  services.cloudflare-warp.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    gnome-extension-manager
    cloudflare-warp
    morewaita-icon-theme
    curl
    devenv
  ] ++ (with pkgs.gnomeExtensions; [
    hot-edge
    caffeine
  ]);
  
  # Enable the Nautilus "Open Any Terminal" extension globally
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "ptyxis"; 
  };
  
  # QT Platform integration
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  system.stateVersion = "26.05";
}
