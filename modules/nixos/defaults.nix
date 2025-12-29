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
      sddm = {
        enable = true;
        autoNumlock = true;
        autoLogin.relogin = false;
      };

      autoLogin = {
        enable = true;
        user = "ethank";
      };

      defaultSession = "hyprland";
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
      package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
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
      protonplus
      wget
      #aseprite
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
      #impala
      brightnessctl
      feh
      kdePackages.ark
      wlr-randr
      acpi
      pwvucontrol
      libreoffice
      tor-browser
      hunspellDicts.en-us
      helvum
      jetbrains.idea-community-bin
      #logisim-evolution
      chromium
      itch
      zed-editor
      zig
      odin
      jetbrains.idea-community
      jetbrains.clion
      fastfetch
      go
    ];

    programs.nix-ld.enable = true;
      programs.nix-ld.libraries = [
        pkgs.stdenv.cc.cc
        #pkgs.stdenv.cc.cc.lib
     ];

    programs.virt-manager.enable = true;
    programs.kdeconnect.enable = false;
    programs.firefox.enable = true;
    #programs.chromium.enable = true;
    
      programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # List by default
      zlib
      zstd
      stdenv.cc.cc
      curl
      openssl
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      util-linux
      xz
      systemd
      
      # My own additions
      xorg.libXcomposite
      xorg.libXtst
      xorg.libXrandr
      xorg.libXext
      xorg.libX11
      xorg.libXfixes
      libGL
      libva
      pipewire
      xorg.libxcb
      xorg.libXdamage
      xorg.libxshmfence
      xorg.libXxf86vm
      libelf

      # Required
      glib
      gtk2

      # Inspired by steam
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/st/steam/package.nix#L36-L85
      networkmanager      
      vulkan-loader
      libgbm
      libdrm
      libxcrypt
      coreutils
      pciutils
      zenity
      # glibc_multi.bin # Seems to cause issue in ARM
      
      # # Without these it silently fails
      xorg.libXinerama
      xorg.libXcursor
      xorg.libXrender
      xorg.libXScrnSaver
      xorg.libXi
      xorg.libSM
      xorg.libICE
      gnome2.GConf
      nspr
      nss
      cups
      libcap
      SDL2
      libusb1
      dbus-glib
      ffmpeg
      # Only libraries are needed from those two
      libudev0-shim
      
      # needed to run unity
      gtk3
      icu
      libnotify
      gsettings-desktop-schemas
      # https://github.com/NixOS/nixpkgs/issues/72282
      # https://github.com/NixOS/nixpkgs/blob/2e87260fafdd3d18aa1719246fd704b35e55b0f2/pkgs/applications/misc/joplin-desktop/default.nix#L16
      # log in /home/leo/.config/unity3d/Editor.log
      # it will segfault when opening files if you don’t do:
      # export XDG_DATA_DIRS=/nix/store/0nfsywbk0qml4faa7sk3sdfmbd85b7ra-gsettings-desktop-schemas-43.0/share/gsettings-schemas/gsettings-desktop-schemas-43.0:/nix/store/rkscn1raa3x850zq7jp9q3j5ghcf6zi2-gtk+3-3.24.35/share/gsettings-schemas/gtk+3-3.24.35/:$XDG_DATA_DIRS
      # other issue: (Unity:377230): GLib-GIO-CRITICAL **: 21:09:04.706: g_dbus_proxy_call_sync_internal: assertion 'G_IS_DBUS_PROXY (proxy)' failed
      
      # Verified games requirements
      xorg.libXt
      xorg.libXmu
      libogg
      libvorbis
      SDL
      SDL2_image
      glew110
      libidn
      tbb
      
      # Other things from runtime
      flac
      freeglut
      libjpeg
      libpng
      libpng12
      libsamplerate
      libmikmod
      libtheora
      libtiff
      pixman
      speex
      SDL_image
      SDL_ttf
      SDL_mixer
      SDL2_ttf
      SDL2_mixer
      libappindicator-gtk2
      libdbusmenu-gtk2
      libindicator-gtk2
      libcaca
      libcanberra
      libgcrypt
      libvpx
      librsvg
      xorg.libXft
      libvdpau
      # ...
      # Some more libraries that I needed to run programs
      pango
      cairo
      atk
      gdk-pixbuf
      fontconfig
      freetype
      dbus
      alsa-lib
      expat
      # for blender
      libxkbcommon

      libxcrypt-legacy # For natron
      libGLU # For natron

      # Appimages need fuse, e.g. https://musescore.org/fr/download/musescore-x86_64.AppImage
      fuse
      e2fsprogs
    ];
  };  

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

    networking.wireless.iwd.enable = true;

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
      enable = true;
      flake = inputs.self.outPath;
      allowReboot = true;
      flags = [ "--update-input" "nixpkgs" "--commit-lock-file" ];
      dates = "Mon *-*-* 04:00:00";
    };

    systemd.timers.nh-clean = {
      after = [ "nixos-upgrade.timer" ];
      timerConfig.WakeSystem = true;
      onSuccess = [ "suspend.target" ];
    };
  };
}
