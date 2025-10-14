{ lib, config, pkgs, stylix, ...}:

{
  options.waybar.enable
    = lib.mkEnableOption "enable user module";

  config = lib.mkIf config.waybar.enable {
    programs.waybar = {
      enable = true;
      style = ''
        * {
          border: none;
          border-radius: 0;
          font-family: ${stylix.fonts.monospace.name}, ${stylix.fonts.emoji.name};
          font-size: 14px;
          min-height: 0;
        }
        
        window#waybar {
          background: ${stylix.base16Scheme.scheme.base00};
          color: ${stylix.base16Scheme.scheme.base05};
          border-bottom: 2px solid ${stylix.base16Scheme.scheme.base0D};
          opacity: 0.95;
        }
        
        #workspaces button {
          padding: 0 8px;
          background: transparent;
          color: ${stylix.base16Scheme.scheme.base05};
          border-bottom: 2px solid transparent;
        }
        
        #workspaces button:hover {
          background: ${stylix.base16Scheme.scheme.base01};
        }
        
        #workspaces button.focused {
          background: ${stylix.base16Scheme.scheme.base01};
          border-bottom: 2px solid ${stylix.base16Scheme.scheme.base0D};
        }
        
        #workspaces button.urgent {
          background: ${stylix.base16Scheme.scheme.base08};
          color: ${stylix.base16Scheme.scheme.base00};
        }
        
        #mode {
          background: ${stylix.base16Scheme.scheme.base08};
          color: ${stylix.base16Scheme.scheme.base00};
          padding: 0 8px;
          margin: 0 4px;
          border-radius: 4px;
        }
        
        #clock, #battery, #cpu, #memory, #disk, #temperature, #backlight, #network, #pulseaudio, #tray, #mode, #idle_inhibitor, #mpd {
          padding: 0 10px;
          margin: 0 2px;
          color: ${stylix.base16Scheme.scheme.base05};
        }
        
        #clock {
          background: ${stylix.base16Scheme.scheme.base0D};
          color: ${stylix.base16Scheme.scheme.base00};
          font-weight: bold;
          border-radius: 4px;
        }
        
        #battery {
          color: ${stylix.base16Scheme.scheme.base05};
        }
        
        #battery.charging {
          color: ${stylix.base16Scheme.scheme.base0B};
        }
        
        #battery.warning:not(.charging) {
          background: ${stylix.base16Scheme.scheme.base08};
          color: ${stylix.base16Scheme.scheme.base00};
        }
        
        #cpu, #memory, #disk {
          background: ${stylix.base16Scheme.scheme.base02};
          border-radius: 4px;
        }
        
        #network {
          color: ${stylix.base16Scheme.scheme.base0B};
        }
        
        #network.disconnected {
          color: ${stylix.base16Scheme.scheme.base08};
        }
        
        #pulseaudio {
          color: ${stylix.base16Scheme.scheme.base0E};
        }
        
        #pulseaudio.muted {
          color: ${stylix.base16Scheme.scheme.base08};
        }
        
        #tray {
          background: ${stylix.base16Scheme.scheme.base01};
        }
        
        #custom-power {
          color: ${stylix.base16Scheme.scheme.base08};
          padding: 0 12px;
          margin: 0 4px;
          border-radius: 4px;
        }
      '';
      
      settings = {
        height = 30;
        spacing = 4;
        
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ 
          "pulseaudio" 
          "network" 
          "cpu" 
          "memory" 
          "disk" 
          "battery" 
          "tray" 
          "custom/power"
        ];
        
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "󰈹";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "urgent" = "";
            "focused" = "";
            "default" = "";
          };
          persistent-workspaces = {
            "*" = 5;
          };
        };
        
        "hyprland/window" = {
          format = "{}";
          max-length = 50;
        };
        
        "clock" = {
          format = "{:%H:%M}";
          format-alt = "{:%A, %B %d, %Y}";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='${stylix.base16Scheme.scheme.base0D}'><b>{}</b></span>";
              days = "<span color='${stylix.base16Scheme.scheme.base05}'><b>{}</b></span>";
              weeks = "<span color='${stylix.base16Scheme.scheme.base0B}'><b>W{}</b></span>";
              weekdays = "<span color='${stylix.base16Scheme.scheme.base05}'><b>{}</b></span>";
              today = "<span color='${stylix.base16Scheme.scheme.base0D}'><b><u>{}</u></b></span>";
            };
          };
        };
        
        "cpu" = {
          format = "󰍛 {usage}%";
          tooltip = false;
        };
        
        "memory" = {
          format = "󰘚 {}%";
        };
        
        "disk" = {
          format = "󰋊 {percentage_used}%";
          path = "/";
        };
        
        "network" = {
          format-wifi = " {essid}";
          format-ethernet = "󰈀 {ifname}";
          format-linked = "󰈁 {ifname} (No IP)";
          format-disconnected = "󰈂 Disconnected";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}";
        };
        
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰖁 Muted";
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰋎";
            headset = "󰋎";
            phone = "";
            portable = "";
            car = "";
            default = ["󰕿" "󰖀" "󰕾"];
          };
          on-click = "pavucontrol";
        };
        
        "battery" = {
          format = "{icon} {capacity}%";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰚥 {capacity}%";
          format-full = "󰁹 {capacity}%";
          states = {
            warning = 30;
            critical = 15;
          };
        };
        
        "tray" = {
          spacing = 10;
        };
        
        "custom/power" = {
          format = "⏻";
          on-click = "wlogout";
          tooltip = false;
        };
      };
    };
  };
}
