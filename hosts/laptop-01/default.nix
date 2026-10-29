{ config, lib, pkgs, ... }:

{
  networking.hostName = "laptop-01";

  # services.fprintd.enable = true;

  imports = [
    ./disko.nix
    ./hardware.nix
    ./hardware-configuration.nix
  ];
}
