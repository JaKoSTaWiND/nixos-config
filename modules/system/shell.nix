{ config, pkgs, ... }:
let
  vars = import ../../variables.nix;
in
{
  programs.zsh.enable = true;

  home-manager.users.${vars.username} = { pkgs, ... }: {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      
      initContent = ''
        eval "$(starship init zsh)"
      '';
    };

    programs.starship = {
      enable = true;
    };

    home.packages = [ pkgs.fzf ];
  };
}