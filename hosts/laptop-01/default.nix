{ config, lib, pkgs, ... }:

{
  networking.hostName = "laptop-01";

  # services.fprintd.enable = true;

  services.localtimed.enable = true;

  imports = [
    ./disko.nix
    ./hardware.nix
    ./hardware-configuration.nix
  ];
}
