{ config, lib, pkgs, ... }:

{
  networking.hostName = "laptop-01";

  # services.fprintd.enable = true;

  services.localtimed.enable = true;

  systemd.services.battery-charge-threshold = {
    after = [ "multi-user.target" ];
    description = "Set battery charge threshold to 80 percent";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'shopt -s nullglob; for f in /sys/class/power_supply/BAT*/charge_control_end_threshold; do echo 80 > $f; done'";
    };
  };

  imports = [
    ./disko.nix
    ./hardware.nix
    ./hardware-configuration.nix
  ];
}
