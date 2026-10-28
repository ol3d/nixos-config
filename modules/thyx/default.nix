{ config, lib, pkgs, inputs, ... }:

let
  thyxPackage = pkgs.callPackage (inputs.thyx + "/default.nix") { };
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    thyx = {
      enable = true;
      package = thyxPackage.overrideAttrs (old: {
        postInstall = (old.postInstall or "") + ''
          cp ${./theme.conf} "$out/share/sddm/themes/thyx/theme.conf"
        '';
      });
    };
  };
}
