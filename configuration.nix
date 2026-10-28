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

  # Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  
  # Graphics stuff
  hardware.graphics = {
    enable = true;
    enable32Bit = true; 
    extraPackages = with pkgs; [
      intel-media-driver 
      vpl-gpu-rt         
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ intel-media-driver ];
  };

  # Force Wayland/Chromium/Firefox to use the correct Intel VAAPI driver
  environment.sessionVariables = { 
    LIBVA_DRIVER_NAME = "iHD"; 
  };

  # Enable GNOME
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  
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
    jack.enable = true;
  };

  users.users.krishang = {
    isNormalUser = true;
    description = "Krishang";
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "12345"; # Change this immediately after login
    shell = pkgs.fish;
  };

  # Enable cloudflare-warp service
  services.cloudflare-warp.enable = true;

  environment.systemPackages = with pkgs; [
    # Stuff
    git
    vim
    wget
    gnome-extension-manager
    cloudflare-warp
    vscode.fhs
    curl
    devenv
    wl-clipboard
  

    # Plugins 
    vital             # Synth 
    surge-XT          # Synth 
    odin2             # Synth 
    cardinal          # Synth 
    dexed             # Synth 
    zynaddsubfx       # Synth
    geonkick          # Precussion
    hydrogen          # Drum mahcine
    lsp-plugins       # Suite of mixing/mastering plugins
    x42-plugins       # EQ, meters, and utilities
    dragonfly-reverb  # Reverb plugins
    chow-tape-model   # Analog tape saturation
    yabridge          # bridge Windows VSTs via Wine
    yabridgectl       # CLI to manage yabridge

  ] ++ (with pkgs.gnomeExtensions; [
    hot-edge
    caffeine
  ]);
  
  # Enable the Nautilus "Open Any Terminal" extension globally
  # programs.nautilus-open-any-terminal = {
  #  enable = true;
  #  terminal = "ghostty"; 
  #};

  programs.fish.enable = true;
  
  # QT Platform integration
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports for Source Dedicated Server hosting
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    extraPackages = with pkgs; [
      adwaita-icon-theme
    ];
  };

  programs.gamemode.enable = true;

  # Syncthing
  services.syncthing = {
    enable = true;
    openDefaultPorts = true; # Open ports in the firewall for Syncthing. (!NOTE: this will not open syncthing gui port)
    user = "krishang";
    configDir = "/home/krishang/.config/syncthing";
  };

  # Enable flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";
}
