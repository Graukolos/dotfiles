{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager }: {
    nixosConfigurations.beren = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/beren.nix

	      home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
	        home-manager.useUserPackages = true;

	        home-manager.users.graukolos = ./home/beren.nix;
	      }
      ];
    };
  };
}
