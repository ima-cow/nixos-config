{ config, pkgs, ... }:

{
  imports =
    [
      ../../modules/home-manager/modules.nix
      ../../modules/home-manager/defaults.nix
    ];

  home-manager-defaults.enable = true;

  git.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJHd3NXQi3CAB1sB67Mp/qywa4BhZtoDpayk8e3ovXb7";

  wayland.windowManager.hyprland.settings = {
    gesture = [
      "3, horizontal, workspace"
    ];
  };

  hypridle = {
    timeout-off = "suspend-then-hibernate";
  };

  programs.hyprlock.settings.auth.fingerprint.enabled = true;

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
