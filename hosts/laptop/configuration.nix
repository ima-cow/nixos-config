{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ../../modules/nixos/modules.nix
      ../../modules/nixos/defaults.nix
    ];

  nixos-defaults.enable = true;

  networking.hostName = "laptop";

   networking.wireless.networks.eduroam = {
   auth = ''
     key_mgmt=WPA-EAP
     eap=PWD
     identity="eikrall@ucsc.edu"
     password="PORT@santa26"
   '';
 };

  security.pki.certificateFiles = [ "/etc/nixos/other/ca.crt" ];

  services.logind.settings.Login = {
    HandlePowerKey = "hibernate";
    HandlePowerKeyLongPress = "poweroff";
    HandleLidSwitch = "suspend-then-hibernate";
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "ethank" = import ./home.nix;
    };
    backupFileExtension = "backup";
  };

  services.fprintd.enable = true;

  stylix-config = {
    wallpaper = ../../other/wallpapers/wallpaper_2.jpg;
    theme = {
      enable = false;
      scheme = "catppuccin-mocha";
    };
  };

  system.stateVersion = "25.05";
}
