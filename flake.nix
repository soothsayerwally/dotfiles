{
  description = "Krishang's Pretty Neat Flake";
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
  };

  outputs = inputs @ { self, nixpkgs, disko, home-manager, flake-parts, ... }: {
    flake-parts.lib.mkflake { inherit inputs; }
    {
      systems = [ "x86_64-linux" ];
    }
    nixosConfigurations.reverie = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
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
          home-manager.users.krishang = import ./modules/home;
        }
      ];
    };
  };
}
