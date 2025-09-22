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

    starship-preset-url = lib.mkOption {
      default = "https://starship.rs/presets/toml/gruvbox-rainbow.toml";
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
      settings = lib.importTOML builtins.fetchurl cfg.starship-preset-url;
    };

    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
