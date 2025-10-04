{ lib, config, pkgs, ... }:

let 
  cfg = config.stylix-config;
in
{
  options.stylix-config = {
    enable
      = lib.mkEnableOption "enable user module";

    theme = {
      enable 
        = lib.mkEnableOption "enable user module";

      scheme = lib.mkOption {
        default = "tomorrow-night";
      };
    }; 
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;

      base16Scheme = lib.mkIf cfg.theme.enable 
        "${pkgs.base16-schemes}/share/themes/${cfg.theme.scheme}.yaml";
      polarity = "dark";

      image = ../../other/wallpaper.jpg;

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 1;
      };

      opacity.terminal = 0.8;
    };
  };
}
