{ config, pkgs, ... }:
let
  vars = import ../../variables.nix;
in
{
  home-manager.users.${vars.username} = { pkgs, ... }: {
    home.packages = [
      pkgs.python315
    ];
  };
}