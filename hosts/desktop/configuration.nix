{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos/modules.nix
      inputs.home-manager.nixosModules.default 
      ../../modules/nixos/defaults.nix
    ];

  nixos-defaults.enable = true;

  fileSystems."/mnt/secondary" =
  { 
    device = "/dev/disk/by-uuid/906e4ae0-92e9-45c8-b19f-cac2b1038f5c";
    fsType = "btrfs";
  };

  networking.hostName = "desktop";

  nvidia-drivers.enable = true;

  services.logind.settings.Login = {
    HandlePowerKey = "suspend";
    HandlePowerKeyLongPress = "poweroff";
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { 
      "ethank" = import ./home.nix;
    };
    backupFileExtension = "backup";
  };
   
  # DO NOT CHANGE
  system.stateVersion = "25.05"; 

}
