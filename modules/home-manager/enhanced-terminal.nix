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
      settings = lib.importTOML ../../other/dotfiles/starship.toml;
    };

    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
