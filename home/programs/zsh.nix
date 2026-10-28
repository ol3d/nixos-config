{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    # Wraps task so it always runs this repository's Taskfile, from any directory
    initContent = ''
      task() { command task -d "$HOME/workspace/nixos-config" "$@"; }
    '';
    history = {
      ignoreDups = true;
      ignoreSpace = true;
    };
  };
}
