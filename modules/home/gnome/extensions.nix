{ pkgs, ... }: {
 home.packages = with pkgs.gnomeExtensions; [
    gsconnect
    hot-edge
  ]; 
}
