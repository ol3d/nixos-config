{ config, lib, pkgs, ... }:

{
  home.file.".ssh/known_hosts.github".text = ''
    github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
  '';

  programs.ssh = {
    enable = true;
    matchBlocks."github.com" = {
      hostname = "github.com";
      user = "git";
      identityFile = "${config.home.homeDirectory}/.ssh/github_id_ed25519";
      identitiesOnly = true;
      userKnownHostsFile = "${config.home.homeDirectory}/.ssh/known_hosts.github ${config.home.homeDirectory}/.ssh/known_hosts";
    };
  };
}
