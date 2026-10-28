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

    thyx.url = "github:rccyx/thyx";
  };

  outputs =
    inputs:
    let
      inherit (import ./lib { inherit inputs; }) mkHost;
    in
    {
      nixosConfigurations = {
        laptop-01 = mkHost ./hosts/laptop-01;
      };
    };
}
