{ config, pkgs, ... }:

{
  imports =
    [
      ../../modules/home-manager/modules.nix
      ../../modules/home-manager/defaults.nix
    ];

  home-manager-defaults.enable = true;

  git.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJHd3NXQi3CAB1sB67Mp/qywa4BhZtoDpayk8e3ovXb7";

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
