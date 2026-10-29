{ config, lib, pkgs, ... }:

{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  system.autoUpgrade = {
    enable = true;
    flake = "github:ol3d/nixos-config";
    dates = "daily";
    randomizedDelaySec = "45min";
    allowReboot = false;
  };

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 20;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.plymouth = {
    enable = true;
    theme = "nixos-bgrt";
    themePackages = [ pkgs.nixos-bgrt-plymouth ];
  };

  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
  };
  networking.firewall.enable = true;

  time.timeZone = lib.mkDefault "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.ol3d = {
    isNormalUser = true;
    initialPassword = "changeme";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  programs.zsh.enable = true;

  hardware.enableRedistributableFirmware = true;

  services.fstrim.enable = true;
  services.fwupd.enable = true;

  system.stateVersion = "26.05";
}
