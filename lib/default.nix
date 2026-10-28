{ inputs, ... }:

let
  system = "x86_64-linux";

  sharedModules = [
    inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops
    inputs.thyx.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useUserPackages = true;
      home-manager.users.ol3d = import ../home;
      home-manager.sharedModules = [
        inputs.sops-nix.homeManagerModules.sops
      ];
    }
    ../modules/core.nix
    ../modules/desktop.nix
    ../modules/thyx
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
