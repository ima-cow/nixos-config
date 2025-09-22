{ lib,  config, pkgs, ... }:

{
  imports = 
    [
      ./git.nix
      ./enhanced-terminal.nix
    ];
}

