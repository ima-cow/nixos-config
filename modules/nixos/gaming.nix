{ lib, config, pkgs, ... }:

{
  options.gaming.enable
    = lib.mkEnableOption "enabel user module";

  config = lib.mkIf config.gaming.enable {
    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;
    programs.gamemode.enable = true;
  };
}
