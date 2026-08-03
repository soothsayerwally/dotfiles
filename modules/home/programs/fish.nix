{ ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = [
    { name = "fzf-fish"; pkgs.fishPlugins.fzf; } 
    { name = "colored-man-pages"; pkgs.fishPlugins.colored-man-pages; }
    { name = "tide"; pkgs.fishPlugins.tide; }
    { name = "done"; pkgs.fishPlugins.done; }
    ];
  };
}

