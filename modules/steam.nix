{ config, pkgs, ... }:
let
  vars = import ../variables.nix;
in
{
  programs.steam.enable = true; 
  programs.gamemode.enable = true; # Оптимизация

  home-manager.users.${vars.username} = {
    home.packages = with pkgs; [
      protonup-qt 
      steam-run
    ];
  };
}