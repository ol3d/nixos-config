{ config, lib, pkgs, ... }:

{
  sops.secrets.git-email = {
    sopsFile = ../../secrets/common.sops.yaml;
  };

  programs.git = {
    enable = true;
    settings = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "${config.home.homeDirectory}/.ssh/github_id_ed25519.pub";
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
