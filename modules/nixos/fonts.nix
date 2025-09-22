{ lib, config, pkgs, ... }:

{
  options.fonts.enable
    = lib.mkEnableOption "enable user module";

  config = lib.mkIf config.fonts.enable {
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.hack
      nerd-fonts.agave
      nerd-fonts.gohufont
    ];
  };
}
