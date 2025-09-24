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

    session-wide = lib.mkOption {
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.mangohud = {
      enable = true;
      enableSessionWide = cfg.session-wide;
      settings = {
        fps_limit = cfg.fps-limit;
        preset = cfg.preset;
        position = "top-right"; 
      };
    };
  };
}
