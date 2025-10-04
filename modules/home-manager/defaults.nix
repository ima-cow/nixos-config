{ config, pkgs, lib, inputs, ... }:

{
  imports = [./modules.nix];

  options.home-manager-defaults.enable 
    = lib.mkEnableOption "enable user module";

  config = lib.mkIf config.home-manager-defaults.enable {
    home.username = "ethank";
    home.homeDirectory = "/home/ethank"; 

    home.packages = with pkgs; [
      zoxide
      ghostty
      starship
      wofi
      waybar
    ];

    services.hyprpaper.enable = true;
 
    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/ethank/etc/profile.d/hm-session-vars.sh
    #
    home.sessionVariables = {
      # EDITOR = "emacs";
    };

    git.enable = true;

    enhanced-terminal = {
      enable = true;
    };
    
  };
}
