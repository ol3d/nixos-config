{ config, lib, pkgs, ... }:

{
  home.username = "ol3d";
  home.homeDirectory = "/home/ol3d";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    nerd-fonts.commit-mono
    go-task
    openssh
    sops
  ];

  systemd.user.tmpfiles.rules = [
    "d %h/workspace 0755 - -"
  ];

  sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

  imports = [
    ./programs/delta.nix
    ./programs/firefox.nix
    ./programs/git.nix
    ./programs/kitty.nix
    ./programs/neovim.nix
    ./programs/ssh.nix
    ./programs/zsh.nix
  ];
}
