{ ... }: {
  # Opens necessary firewall ports for device discover
  services.kdeconnect = {
    enable = true;
    package = pkgs.valent;
  };
}
