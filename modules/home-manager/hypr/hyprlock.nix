{ lib, config, pkgs, ...}:

{
  options.hyprlock.enable
    = lib.mkEnableOption "enable user module";

  config = lib.mkIf config.hyprlock.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 300;
          hide_cursor = true;
          no_fade_in = false;
        };
      
        background = {
          blur_passes = 3;
          blur_size = 8;
        };
      
        input-field = {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          outline_thickness = 5;
          placeholder_text = "Password...";
          shadow_passes = 2;
        };

        label = { 
          text = "cmd[update:1000] echo \"$(date +\"%-I:%M\")\"";
          position = "0, 100";
          halign = "center";
          valign = "center";
          font_size = "200";
          shadow_passes = 3;
        };
      };
    };
  };
}
