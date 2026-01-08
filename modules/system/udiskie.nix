{ pkgs, ... }:
let vars = import ../../variables.nix; in
{
  home-manager.users.${vars.username} = {
    home.packages = [ pkgs.udiskie ];
    # Запуск udiskie автоматически при входе
    services.udiskie.enable = true;
  };
}