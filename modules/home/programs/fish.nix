{ pkgs, ... }: {
  programs.fish = {
    enable = true;

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles/#reverie";
      v = "nvim";
    };

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = [
    { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; } 
    { name = "colored-man-pages"; src = pkgs.fishPlugins.grc.src; }
    { name = "pure"; src = pkgs.fishPlugins.pure.src; }
    { name = "done"; src = pkgs.fishPlugins.done.src; }
    ];
  };
}

