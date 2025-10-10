{ config, pkgs, ... }:

{
  imports =
    [
      ../../modules/home-manager/modules.nix
      ../../modules/home-manager/defaults.nix
    ];

  home-manager-defaults.enable = true;

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
