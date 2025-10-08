{ lib, config, pkgs, ...}:

{
  options.hypridle.enable
    = lib.mkEnableOption "enable user module";

  config = lib.mkIf config.hypridle.enable {
    programs.hypridle = {
      enable = true;
    };
  };
}
