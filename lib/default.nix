{ inputs, ... }:

let
  system = "x86_64-linux";

  sharedModules = [
    inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.users.ol3d = import ../home;
      home-manager.sharedModules = [
        inputs.sops-nix.homeManagerModules.sops
      ];
    }
    ../modules/core.nix
    ../modules/desktop.nix
    ../modules/dev.nix
  ];

  mkHost =
    path:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs;
      };
      modules = sharedModules ++ [ path ];
    };
in
{
  inherit mkHost;
}
