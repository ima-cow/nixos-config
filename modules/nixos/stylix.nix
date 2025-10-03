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

      base16Scheme = lib.mkIf cfg.theme.enable lib.concatStrings ["${pkgs.base16-schemes}/share/themes/" cfg.theme.scheme ".yaml"];
      polarity = "dark";

      image = ../../other/wallpaper.jpg;
    };
  };
}
