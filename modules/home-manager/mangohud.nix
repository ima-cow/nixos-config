{ lib, config, pkgs, ... }:

let 
  cfg = config.mangohud;
in
{
  options.mangohud = {
    enable 
     = lib.mkEnableOption "enable user module";

    preset = lib.mkOption {
      default = -1;
    };

    fps-limit = lib.mkOption {
      default = 60;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.mangohud = {
      enable = true;
      settings = {
        fps_limit = cfg.fps-limit;
        preset = cfg.preset;
      };
    };
  };
}
