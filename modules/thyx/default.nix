{ config, lib, pkgs, inputs, ... }:

let
  thyxPackage = pkgs.callPackage (inputs.thyx + "/default.nix") { };
  qmlImportPath = lib.concatStringsSep ":" (
    map (p: "${p}/lib/qt-6/qml") (
      with pkgs.qt6; [
        qtdeclarative
        qtmultimedia
        qt5compat
        qtsvg
      ]
    )
  );
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    settings.General.GreeterEnvironment = "QT_WAYLAND_SHELL_INTEGRATION=layer-shell,QML2_IMPORT_PATH=${qmlImportPath},QML_IMPORT_PATH=${qmlImportPath}";
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
