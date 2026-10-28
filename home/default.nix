{ config, lib, pkgs, ... }:

{
  home.username = "ol3d";
  home.homeDirectory = "/home/ol3d";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    nerd-fonts.commit-mono
    go-task
    sops
  ];

  systemd.user.tmpfiles.rules = [
    "d %h/workspace 0755 - -"
  ];

  sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

  imports = [
    ./programs/firefox.nix
    ./programs/git.nix
    ./programs/kitty.nix
    ./programs/neovim.nix
    ./programs/zsh.nix
  ];
}
