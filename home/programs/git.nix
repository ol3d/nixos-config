{ config, lib, pkgs, ... }:

{
  sops.secrets.git-email = {
    sopsFile = ../../secrets/common.sops.yaml;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Adam Delo";
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      };
    };
    includes = [
      {
        path = "${config.sops.secrets.git-email.path}";
      }
    ];
  };
}
