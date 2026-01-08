{ config, pkgs, ... }:

let
  vars = import ./variables.nix;
in
{
  imports = [ 
    <home-manager/nixos>
    ./hardware-configuration.nix

    # --- SYSTEM ---
    ./modules/system/shell.nix # Zsh в терминале
    ./modules/system/udiskie.nix # Udiskie для автомонтирование дисков
    
    # --- PROGRAMMING_LANGUAGES ---
    ./modules/programming_languages/python.nix # Python 3.15v
    ./modules/programming_languages/java.nix # Java JDK 25v

    ./modules/kitty.nix # Kitty terminal
    ./modules/steam.nix # Steam
    ./modules/vscode.nix # VSCode
    ./modules/firefox_dev_edition.nix # Firefox
    ./modules/chrome.nix # Chrome
    ./modules/discord.nix # Discord

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

  # Автоматическое монтирование дисков
  boot.supportedFilesystems = [ "ntfs" ];
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Включение поддержки Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Утилита для управления (удобная иконка в трее)
  services.blueman.enable = true;

  # Nvidia драйвера
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = false; 
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Разрешаем несвободные пакеты
  nixpkgs.config.allowUnfree = true;

  # Системные пакеты (базовый минимум)
  environment.systemPackages = with pkgs; [
    wget
    git
    ntfs3g
  ];

  # Настройка пользователя
  users.users.${vars.username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = vars.username;
    extraGroups = [ "networkmanager" "wheel" "gamemode" ];
  };

  # --- КОНФИГУРАЦИЯ HOME MANAGER ---
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  
  home-manager.users.${vars.username} = {
    home.stateVersion = "25.11";
  };

  # Шрифты
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  system.stateVersion = "25.11";
}