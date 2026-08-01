{ ... }: {
  users.users.krishang = {
    isNormalUser = true;
    description = "Krishang";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}

