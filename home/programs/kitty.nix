{ config, lib, pkgs, ... }:

{
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
}
