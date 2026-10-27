{ config, lib, pkgs, ... }:

{
  home.username = "ol3d";
  home.homeDirectory = "/home/ol3d";
  home.stateVersion = "26.05";

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    secrets.git-email = {
      sopsFile = ../secrets/common.sops.yaml;
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Adam Delo";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
    includes = [
      {
        path = "${config.sops.secrets.git-email.path}";
      }
    ];
  };

  programs.kitty = {
    enable = true;
    themeFile = "Dracula";
    settings = {
      font_size = "11";
      scrollback_lines = "10000";
      enable_audio_bell = false;
      background_opacity = "0.95";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      ignoreDups = true;
      ignoreSpace = true;
    };
  };
}
