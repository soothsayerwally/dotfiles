{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = [
    { name = "fzf-fish"; src = pkgs.fishPlugins.fzf.src; } 
    { name = "colored-man-pages"; src = pkgs.fishPlugins.colored-man-pages.src; }
    { name = "pure"; src = pkgs.fishPlugins.pure.src; }
    { name = "done"; src = pkgs.fishPlugins.done.src; }
    ];
  };
}

