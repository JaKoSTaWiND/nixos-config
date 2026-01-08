{ config, pkgs, ... }:
let
  vars = import ../variables.nix;
in
{
  home-manager.users.${vars.username} = {
    programs.vscode = {
      enable = true;

      # Расширения
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          bbenoist.nix
          ms-python.python
        ];
      };
    };
  };
}