{ config, lib, pkgs, ... }:

{
  services.xserver.enable = true;

  services.xserver.excludePackages = [ pkgs.xterm ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [
      pkgs.intel-media-driver
      pkgs.vpl-gpu-rt
    ];
  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  services.printing.enable = true;

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media";
      };
    };
  };

  # programs.kdeconnect.enable = true;

  programs.steam.enable = true;

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    curl
    git
    iw
    libva-utils
    wget
  ];
}
