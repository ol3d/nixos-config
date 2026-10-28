{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    # Runs the nearest Taskfile up the tree, falling back to this repository
    initContent = ''
      task() {
        local d=$PWD
        while [ "$d" != "/" ]; do
          if [ -f "$d/Taskfile.yaml" ] || [ -f "$d/Taskfile.yml" ]; then
            command task "$@"
            return
          fi
          d=$(dirname "$d")
        done
        command task -d "$HOME/workspace/nixos-config" "$@"
      }
    '';
    history = {
      ignoreDups = true;
      ignoreSpace = true;
    };
  };
}
