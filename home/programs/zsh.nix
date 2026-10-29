{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = lib.mkMerge [
      (lib.mkOrder 550 ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/config/p10k-classic.zsh
      '')
      (lib.mkOrder 1000 ''
        task() { command task -d "$HOME/workspace/nixos-config" "$@"; }
      '')
    ];
    history = {
      ignoreDups = true;
      ignoreSpace = true;
    };
  };
}
