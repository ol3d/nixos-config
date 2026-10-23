{ config, lib, pkgs, modulesPath, ... }:

{
  boot.initrd.availableKernelModules = [
    "ahci"
    "nvme"
    "vmd"
  ];
}
