{ config, pkgs, ... }:
let
  vars = import ../variables.nix;
in
{
  home-manager.users.${vars.username} = {
    programs.kitty = {
      enable = true;
      font.name = "JetBrainsMono Nerd Font";
      settings = {
        background_opacity = "0.85";
        confirm_os_window_close = 0;
      };
    };
  };
}