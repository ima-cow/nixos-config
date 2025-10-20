{ config, pkgs, ... }:

{
  imports = 
    [
      ../../modules/home-manager/modules.nix
      ../../modules/home-manager/defaults.nix
    ];

  home-manager-defaults.enable = true;

  git.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF8QEULcEEp6/t+tdcYCYsQc6Sm4Qpatl1ODnQvQMD6K";

  mangohud = {
    enable = true;
    fps-limit = 170;
    preset = 3;
    session-wide = false;
  };

  hypridle = {
    brightness-down = "";
    brightness-restore = "";
  };


  home.stateVersion = "25.05"; # DO NOT CHANGE
  programs.home-manager.enable = true;
}
