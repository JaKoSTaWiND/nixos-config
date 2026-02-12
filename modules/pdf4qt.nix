let vars = import ../variables.nix; in
{
  home-manager.users.${vars.username}.home.packages = [ pkgs.pdf4qt ];
}
