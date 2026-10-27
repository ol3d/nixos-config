{ config, lib, pkgs, ... }:

{
  networking.hostName = "laptop-01";

  imports = [
    ./disko.nix
    ./hardware.nix
    ./hardware-configuration.nix
  ];
}
