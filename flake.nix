{
  description = "Krishang's Pretty Neat Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, home-manager, ... }@inputs: {
    nixosConfigurations.reverie = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      # Pass 'inputs' to top-level nixos modules, whatever that means
      specialArgs = { inherit inputs; };

      modules = [
        ./hosts/reverie

	# Disko
	disko.nixosModules.disko
	./disko-config.nix

        # Home Manager module
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
	  home-manager.backupFileExtension = "backup";
	  home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.krishang = import ./modules/home;
        }
      ];
    };
  };
}
