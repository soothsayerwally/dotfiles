{ pkgs, ... }: {
  # Display & Desktop Manager
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Excluded GNOME Applications
  environment.gnome.excludePackages = with pkgs; [ 
    gnome-tour 
    gnome-user-docs 
    epiphany 
    showtime 
    yelp 
    gnome-music 
    xterm 
    gnome-console 
  ];

  # Sensor support (auto-rotate)
  hardware.sensor.iio.enable = true;

  # QT Platform integration
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
