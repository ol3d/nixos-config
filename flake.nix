{
  description = "NixOS configurations for personal machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      disko,
      sops-nix,
      nixos-hardware,
    }:
    let
      system = "x86_64-linux";

      sharedModules = [
        disko.nixosModules.disko
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
        {
          home-manager.users.ol3d = import ./home;
          home-manager.sharedModules = [
            sops-nix.homeManagerModules.sops
          ];
        }
        ./modules/core
        ./modules/desktop
        ./modules/dev
      ];

      mkHost =
        path:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
          };
          modules = sharedModules ++ [ path ];
        };
    in
    {
      nixosConfigurations = {
        laptop-01 = mkHost ./hosts/laptop-01;
      };
    };
}
