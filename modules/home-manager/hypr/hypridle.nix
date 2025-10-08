{ lib, config, pkgs, ...}:

let
  cfg = config.hypridle;
in
{
  options.hypridle =  {
    enable = lib.mkEnableOption "enable user module";

    timeout-off = lib.mkOption {
      default = "suspend";
    };

    keyboard-backlight = lib.mkOption {
      default = "rgb:kbd_backlight";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.hypridle = {
      enable = true;

      listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl -sd ${cfg.keyboard-backlight} set 0";
          on-resume = "brightnessctl -rd ${cfg.keyboard-backlight}";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
        }
        {
          timeout = 1800;
          on-timeout = "systemctl ${cfg.timeout-off}";
        }
      ];
    };
  };
}
