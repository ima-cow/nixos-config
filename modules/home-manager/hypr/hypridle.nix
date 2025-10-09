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
  };

  config = lib.mkIf cfg.enable {
    services.hypridle = {
      enable = true;

      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 10;
            on-timeout = "echo \"timeout 1\" > ~/filename1.txt";
            on-resume =  "echo \"resume 1\" > ~/filename2.txt";
          }
          {
            timeout = 20;
            on-timeout = "echo \"timeout 2\" > ~/filename3.txt";
            on-resume =  "echo \"resume 2\" > ~/filename4.txt";
          }
          {
            timeout = 150;
            on-timeout = "ddcutil dumpvcp /home/ethank/.local/share/ddcutil/prvset.vcp && ddcutil setvcp 10 10";
            on-resume = "ddcutil loadvcp /home/ethank/.local/share/ddcutil/prvset.vcp";
          }
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 330;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 1800;
            on-timeout = "systemctl ${cfg.timeout-off}";
          }
        ];
      };
    };
  };
}
