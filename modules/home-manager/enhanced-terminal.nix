{ lib, config, pkgs, ... }:

let
  cfg = config.enhanced-terminal;
in
{
  options.enhanced-terminal= {
    enable 
      = lib.mkEnableOption "enable user module";

    font = lib.mkOption {
      default = "Hack Nerd Font";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.fish.enable = true;

    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      settings = { 
        font-family = cfg.font;
      };
    };

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      enableInteractive = true;
      settings = {
        "$schema" = "https://starship.rs/config-schema.json";
        
        format = lib.concatStrings [
          "[](red)"
          "$os"
          "$username"
          "[](bg:orange fg:red)"
          "$directory"
          "[](bg:yellow fg:orange)"
          "$git_branch"
          "$git_status"
          "[](fg:yellow bg:green)"
          "$c"
          "$rust"
          "$golang"
          "$nodejs"
          "$php"
          "$java"
          "$kotlin"
          "$haskell"
          "$python"
          "[](fg:green bg:cyan)"
          "$conda"
          "[](fg:cyan bg:magenta)"
          "$time"
          "[ ](fg:magenta)"
          "$cmd_duration"
          "$line_break"
          "$character"
        ];

        os = {
          disabled = false;
          style = "bg:red fg:bright-white";
          symbols = {
            Windows = "";
            Ubuntu = "󰕈";
            SUSE = "";
            Raspbian = "󰐿";
            Mint = "󰣭";
            Macos = "󰀵";
            Manjaro = "";
            Linux = "󰌽";
            Gentoo = "󰣨";
            Fedora = "󰣛";
            Alpine = "";
            Amazon = "";
            Android = "";
            Arch = "󰣇";
            Artix = "󰣇";
            CentOS = "";
            Debian = "󰣚";
            Redhat = "󱄛";
            RedHatEnterprise = "󱄛";
            NixOS = " ";
          };
        };

        username = {
          show_always = true;
          style_user = "bg:red fg:bright-white";
          style_root = "bg:red fg:bright-white";
          format = "[ $user]($style)";
        };

        directory = {
          style = "bg:orange fg:bright-white";
          format = "[ $path ]($style)";
          truncation_length = 3;
          truncation_symbol = "…/";
          substitutions = {
            Documents = "󰈙 ";
            Downloads = " ";
            Music = "󰝚 ";
            Pictures = " ";
            Developer = "󰲋 ";
          };
        };

        git_branch = {
          symbol = "";
          style = "bg:yellow";
          format = "[[ $symbol $branch ](fg:bright-white bg:yellow)]($style)";
        };

        git_status = {
          style = "bg:yellow";
          format = "[[($all_status$ahead_behind )](fg:bright-white bg:yellow)]($style)";
        };

        nodejs = {
          symbol = "";
          style = "bg:green";
          format = "[[ $symbol( $version) ](fg:bright-white bg:green)]($style)";
        };

        c = {
          symbol = " ";
          style = "bg:green";
          format = "[[ $symbol( $version) ](fg:bright-white bg:green)]($style)";
        };

        rust = {
          symbol = "";
          style = "bg:green";
          format = "[[ $symbol( $version) ](fg:bright-white bg:green)]($style)";
        };

        golang = {
          symbol = "";
          style = "bg:green";
          format = "[[ $symbol( $version) ](fg:bright-white bg:green)]($style)";
        };

        php = {
          symbol = "";
          style = "bg:green";
          format = "[[ $symbol( $version) ](fg:bright-white bg:green)]($style)";
        };

        java = {
          symbol = " ";
          style = "bg:green";
          format = "[[ $symbol( $version) ](fg:bright-white bg:green)]($style)";
        };

        kotlin = {
          symbol = "";
          style = "bg:green";
          format = "[[ $symbol( $version) ](fg:bright-white bg:green)]($style)";
        };

        haskell = {
          symbol = "";
          style = "bg:green";
          format = "[[ $symbol( $version) ](fg:bright-white bg:green)]($style)";
        };

        python = {
          symbol = "";
          style = "bg:green";
          format = "[[ $symbol( $version)(\\(#$virtualenv\\)) ](fg:bright-white bg:green)]($style)";
        };

        docker_context = {
          symbol = "";
          style = "bg:cyan";
          format = "[[ $symbol( $context) ](fg:bright-white bg:cyan)]($style)";
        };

        conda = {
          symbol = "  ";
          style = "fg:bright-white bg:cyan";
          format = "[$symbol$environment ]($style)";
          ignore_base = false;
        };

        time = {
          disabled = false;
          time_format = "%R";
          style = "bg:magenta";
          format = "[[  $time ](fg:bright-white bg:magenta)]($style)";
        };

        character = {
          disabled = false;
          success_symbol = "[❯](bold fg:green)";
          error_symbol = "[❯](bold fg:red)";
          vimcmd_symbol = "[❮](bold fg:green)";
          vimcmd_replace_one_symbol = "[❮](bold fg:magenta)";
          vimcmd_replace_symbol = "[❮](bold fg:magenta)";
          vimcmd_visual_symbol = "[❮](bold fg:yellow)";
        };

        cmd_duration = {
          show_milliseconds = true;
          format = " in $duration ";
          style = "bg:magenta";
          disabled = false;
          show_notifications = true;
          min_time_to_notify = 45000;
        };
      };
    };

    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
