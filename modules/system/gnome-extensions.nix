{ pkgs, ... }: {
 environment.systemPackages = with pkgs.gnomeExtensions; [
    gsconnect
    hot-edge
    caffeine
    appindicator
    blur-my-shell
    dash-to-dock
  ]; 
}
