{ lib, config, pkgs, ... }:

{
  imports = 
    [
      ./nvidia-drivers.nix
      ./ssh.nix
    ];
}

