{ lib, config, pkgs, ...}:

{
  options.fish.enable
    = lib.mkEnableOption "enable user module";

  config = lib.mkIf config.fish.enable {
    users.defaultUserShell = pkgs.fish;
    programs.fish.enable = true;
  };
}
