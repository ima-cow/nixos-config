{ config, pkgs, lib, inputs, ... }:

{
  imports = [./modules.nix];

  options.nixos-defaults.enable 
    = lib.mkEnableOption "enable user module";

  config = lib.mkIf config.nixos-defaults.enable {
    boot.kernelPackages = pkgs.linuxPackages_latest;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    services.displayManager.sddm = {
      enable = true;
      autoNumlock = true;
    };

    nix.settings.experimental-features = [ "nix-command" "flakes"];

    networking.networkmanager.enable = true;

    time.timeZone = "America/New_York";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    services.xserver.enable = true;

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    programs.hyprland = {
      enable = true;
      withUWSM  = false;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };

    services.printing.enable = true;

    hardware.bluetooth.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    users.users.ethank = {
      isNormalUser = true;
      password = "qazxswedc";
      description = "Ethan Krall";
      extraGroups = [ "networkmanager" "wheel" ];
      useDefaultShell = true;
    };

    fish.enable = true;

    stylix-config = {
      enable = true;
      theme.enable = true;
    };

    programs.firefox.enable = true;

    gaming.enable = true;

    nvf.enable = true;

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      vim
      spotify
      godot
      protonplus
      wget
      chromium
      aseprite
      kdePackages.dolphin
      kdePackages.gwenview
      prismlauncher
      cliphist
      wl-clipboard
      xdg-utils
      vesktop
      hyprpolkitagent
      swaynotificationcenter
      hyprshot
    ];

    ssh.enable = true;
    fonts.enable = true;

    services.playerctld.enable = true;

    nix.optimise.automatic = true;
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
