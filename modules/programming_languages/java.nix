{ config, pkgs, ... }:
let
  vars = import ../../variables.nix;
in
{
  home-manager.users.${vars.username} = { pkgs, ... }: {
    home.packages = with pkgs; [
      jdk25_headless
      maven
    ];
  };
}