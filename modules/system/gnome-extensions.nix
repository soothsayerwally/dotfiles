{ pkgs, ... }: {
 environment.systemPackages = with pkgs.gnomeExtensions; [
    gsconnect
    hot-edge
    caffeine
    appindicator
  ]; 
}
