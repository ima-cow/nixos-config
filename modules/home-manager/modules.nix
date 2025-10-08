{ lib,  config, pkgs, ... }:

{
  imports = 
    [
      ./git.nix
      ./enhanced-terminal.nix
      ./mangohud.nix
      ./hypr/hyprland.nix
      ./hypr/waybar.nix
      ./hypr/hyprlock.nix
<<<<<<< HEAD
=======
      ./hypr/hypridle.nix
>>>>>>> 5208547cb0c1e4378f63462f96bde0988e7ff474
    ];
}

