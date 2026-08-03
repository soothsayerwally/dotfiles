{ ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = [
    { name = "fzf-fish"; src = pkgs.fishPlugins.fzf; } 
    { name = "colored-man-pages"; src = pkgs.fishPlugins.colored-man-pages; }
    { name = "tide"; src = pkgs.fishPlugins.tide; }
    { name = "done"; src = pkgs.fishPlugins.done; }
    ];
  };
}

