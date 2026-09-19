{ config, pkgs, lib, inputs, ... }:

{
  imports = [./modules.nix];

  options.nixos-defaults.enable 
    = lib.mkEnableOption "enable user module";

  config = lib.mkIf config.nixos-defaults.enable {
    boot.kernelPackages = pkgs.linuxPackages_latest;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    hardware.i2c.enable = true;

    services.displayManager = {
      enable = true;
      sddm = {
        enable = true;
        autoNumlock = true;
        autoLogin.relogin = false;
        wayland.enable = true;
      };

      autoLogin = {
       enable = true;
       user = "ethank";
      };

      defaultSession = "hyprland-uwsm";
    };

    xdg.portal = {
      enable = true;
    };

    networking.wireless.iwd.enable = false;
    networking.wireless.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes"];

    networking.networkmanager.enable = false;
    networking.wireless.userControlled = true;

    time.timeZone = "America/Los_Angeles";

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
      withUWSM  = true;
      #package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
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
      extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
      useDefaultShell = true;
    };

    fish.enable = true;

    stylix-config = {
     enable = true;
    };

    gaming.enable = true;

    nvf.enable = true;

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      vim
      spotify
      godot
      wget
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
      ddcutil
      bluetui
      brightnessctl
      kdePackages.ark
      wlr-randr
      acpi
      pwvucontrol
      libreoffice
      tor-browser
      hunspellDicts.en-us
      chromium
      itch
      zed-editor
      zig
      fastfetch
    ];


    programs.virt-manager.enable = true;
    programs.kdeconnect.enable = false;
    programs.firefox.enable = true;
    #programs.chromium.enable = true;

    nix-ld.enable = true;

    virtualisation.spiceUSBRedirection.enable = true;
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        vhostUserPackages = with pkgs; [ virtiofsd ];
        swtpm.enable = true;
      };
    };

    ssh.enable = true;
    fonts.enable = true;

    services.playerctld.enable = true;
    services.power-profiles-daemon.enable = true;

    programs.nh = {
      enable = true;
      flake = "/etc/nixos";
      clean = {
        enable = true;
        extraArgs = "--keep 5 --keep-since 7d --optimise";
        dates = "04:00:00";
      };
    };

    system.autoUpgrade = {
      enable = false;
      flake = inputs.self.outPath;
      allowReboot = true;
      flags = [ "--update-input" "nixpkgs" "--commit-lock-file" ];
      dates = "Mon *-*-* 04:00:00";
    };

    systemd.timers.nh-clean = {
      timerConfig.WakeSystem = true;
      onSuccess = [ "suspend.target" ];
    };
  };
}
