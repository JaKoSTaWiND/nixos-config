{ pkgs, ... }:
let
  vars = import ../variables.nix;
in
{
  home-manager.users.${vars.username} = {
    home.packages = [
      pkgs.obsidian
    ];
  };
}