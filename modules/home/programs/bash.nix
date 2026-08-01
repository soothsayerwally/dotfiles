{ ... }: {
  # Bash shell setup
  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles/#reverie";
      v = "nvim";
    };
  };
}
