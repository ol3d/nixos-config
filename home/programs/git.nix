{ config, lib, pkgs, ... }:

{
  sops.secrets.git-email = {
    sopsFile = ../../secrets/common.sops.yaml;
  };

  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      user = {
        name = "Adam Delo";
      };
    };
    includes = [
      {
        path = "${config.sops.secrets.git-email.path}";
      }
    ];
  };
}
