{ pkgs, ... }: {
  # Bootloader & Kernel
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable TRIM
  services.fstrim.enable = true;
  services.fstrim.interval = "weekly";

  # Networking & Printing
  networking.networkmanager.enable = true;
  services.printing.enable = true;

  # Nix Settings & Unfree Packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System-wide utilities
  environment.systemPackages = with pkgs; [
    wl-clipboard
    gnome-tweaks
    nautilus-python # Required for ghostty nautilus integration
  ];
}
