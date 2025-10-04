{ lib, config, pkgs, ...}:

{
  options.waybar.enable
    = lib.mkEnableOption "enable user module";

  config = lib.mkIf config.waybar.enable {
    programs.waybar = {
      enable = true;
    };
  };
}
