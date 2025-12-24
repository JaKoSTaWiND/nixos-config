{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_18; 
    

    authentication = pkgs.lib.mkForce ''
      # TYPE  DATABASE        USER            ADDRESS                 METHOD
      local   all             all                                     trust
      host    all             all             127.0.0.1/32            trust
      host    all             all             ::1/128                 trust
    '';

    ensureUsers = [
      {
        name = "albedooverlord";
        ensureClauses.superuser = true;
        ensureClauses.login = true;
      }
    ];
  };

  environment.systemPackages = [
    pkgs.pgadmin4-desktopmode
  ];
}