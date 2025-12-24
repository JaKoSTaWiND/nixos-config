{ config, pkgs, ... }:

{
  imports = [ 
    <home-manager/nixos>
    ./hardware-configuration.nix
    ./modules/postgresql.nix # PostgreSQL 18v 
    
  ];

  # Загрузчик и базовые настройки системы
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Almaty";
  i18n.defaultLocale = "en_US.UTF-8";

  # Графическая оболочка (KDE Plasma 6)
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Звук и печать
  services.printing.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Включение поддержки Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # Включать адаптер при загрузке

  # Утилита для управления (удобная иконка в трее)
  services.blueman.enable = true;

  # Разрешаем несвободные пакеты
  nixpkgs.config.allowUnfree = true;

  # Системные пакеты (только самое необходимое)
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    crudini # Нужен для автоматической настройки клавиш
  ];

  # Включаем Zsh на системном уровне (необходимо для работы shell)
  programs.zsh.enable = true;

  # Настройка пользователя
  users.users.albedooverlord = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "albedooverlord";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # --- КОНФИГУРАЦИЯ HOME MANAGER ---
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  
  home-manager.users.albedooverlord = { pkgs, ... }: {
    home.stateVersion = "25.11";

    # Программы для пользователя
    home.packages = with pkgs; [
      firefox-devedition
      fzf
      python315
    ];

    # Kitty
    programs.kitty = {
      enable = true;
      font.name = "JetBrainsMono Nerd Font";
      settings = {
        background_opacity = "0.85";
        confirm_os_window_close = 0;
      };
    };

    # Zsh и Starship
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initContent = ''
        eval "$(starship init zsh)"
      '';
    };
    programs.starship.enable = true;

    # Vscode
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        ms-python.python
      ];
    }; 

  };



  # Шрифты
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  system.stateVersion = "25.11";
}
