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

      signing = {
        format = "ssh";
        signByDefault = true;
        key = cfg.key;
       };

      settings = {
        user = {
          name = cfg.userName;
          email = cfg.userEmail;
        };
        init.defaultBranch = "main";
        safe.directory = "/etc/nixos";
        advice.defaultBranchName = "false";
        push.autoSetupRemote = "true";
        pull.rebase = "false";
      };
    };
  };
}
