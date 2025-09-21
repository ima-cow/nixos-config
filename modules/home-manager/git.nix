{ lib, config, pkgs, ... }:

let 
  cfg = config.git;
in
{
  options.git = {
    enable
      = lib.mkEnableOption "enable user module";

    userName = lib.mkOption {
      default = "ima-cow";
    };

    userEmail = lib.mkOption {
      default = "ethanthequag@gmail.com";
    };

    key = lib.mkOption {
      default = "-1";
    };
  };

  config = lib.mkIf cfg.enable  {
    programs.git = {
      enable = true;
      userName = cfg.userName;
      userEmail = cfg.userEmail;

      signing = {
        format = "ssh";
        signByDefault = true;
        key = cfg.key;
       };

      extraConfig = {
        init.defaultBranch = "main";
        safe.directory = "/etc/nixos";
        advice.defaultBranchName = "false";
      };
    };
  };
}
