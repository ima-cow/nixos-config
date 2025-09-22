{ lib, config, pkgs, ... }:

{
  options.ssh.enable
    = lib.mkEnableOption "enable user modual";

  config = lib.mkIf config.ssh.enable {
    services.openssh =  {
      enable = true;
      settings.PasswordAuthentication = false;
    };

    programs.ssh.startAgent = true;
  };
}
