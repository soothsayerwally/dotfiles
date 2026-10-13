{
  description = "Krishang's Pretty Neat Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";        
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf.url = "github:notashelf/nvf";
  };

  outputs = { self, nixpkgs, disko, home-manager, antigravity-nix, nvf, ... }@inputs: {

    # Exposing nvf package
    packages."x86_64-linux".default = 
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [ ./nvf-configuration.nix ];
      }).neovim;

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        disko.nixosModules.disko
        ./disko-config.nix
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };
          
          home-manager.users.krishang = import ./home.nix;
        }
        {
          environment.systemPackages = [
	    self.packages."x86_64-linux".default

            antigravity-nix.packages.x86_64-linux.default # Slop Slop Slop Sahur
            antigravity-nix.packages.x86_64-linux.google-antigravity-ide
            antigravity-nix.packages.x86_64-linux.google-antigravity-cli  
          ];
        }
      ];
    };
  };
}
