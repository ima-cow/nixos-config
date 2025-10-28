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

  services.logind.settings.Login = {
    HandlePowerKey = "hibernate";
    HandlePowerKeyLongPress = "poweroff";
    HandleLidSwitch = "suspend";
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
    wallpaper = ../../other/wallpapers/wallpaper_10.jpg;
    theme = {
      enable = false;
      scheme = "gruvbox-dark";
    };
  };

  system.stateVersion = "25.05";
}
