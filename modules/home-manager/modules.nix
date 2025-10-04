{ lib,  config, pkgs, ... }:

{
  imports = 
    [
      ./git.nix
      ./enhanced-terminal.nix
      ./mangohud.nix
      ./hypr/hyprland.nix
      ./hypr/waybar.nix
    ];
}

