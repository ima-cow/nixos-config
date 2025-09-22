{ lib, config, pkgs, ... }:

let
  cfg = config.enhanced-terminal;
  starship-preset = pkgs.fetchurl {
    url = "https://starship.rs/presets/toml/gruvbox-rainbow.toml";
    sha256 = "0sjw2xzhxqamidfcn6d369skw2rfmyx3a45wz7ww3x7d6d25c1q3";
  };
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
      settings = lib.importTOML starship-preset;
    };

    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
