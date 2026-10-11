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

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
  ];
  
  # Enable the Nautilus "Open Any Terminal" extension globally
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "ptyxis"; 
  };

  system.stateVersion = "26.05";
}
