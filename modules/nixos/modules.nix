{ lib, config, pkgs, ... }:

{
  imports = 
    [
      ./nvidia-drivers.nix
      ./ssh.nix
      ./fish.nix
      ./fonts.nix
      ./gaming.nix
      ./nvf.nix
      ./stylix.nix
    ];
}
