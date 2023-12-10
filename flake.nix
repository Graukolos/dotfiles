{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }@inputs:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        glorfindel = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/glorfindel.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.graukolos = ./home/glorfindel.nix;
            }
          ];
          specialArgs = inputs;
        };

        oneiros = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/oneiros.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.graukolos = ./home/oneiros.nix;
            }
          ];
          specialArgs = inputs;
        };

        ares = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/ares.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.graukolos = ./home/ares.nix;
            }
          ];
          specialArgs = inputs;
        };

        morgoth = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/morgoth.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.graukolos = ./home/morgoth.nix;
            }
          ];
          specialArgs = inputs;
        };
      };

      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          nil
          nixpkgs-fmt
        ];
      };
    };
}
