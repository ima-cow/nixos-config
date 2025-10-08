{ lib, config, pkgs, ... }:

{
  options.nvf.enable
    = lib.mkEnableOption "enabel user module";

  config = lib.mkIf config.nvf.enable {
    programs.nvf = {
      enable = true;

      settings.vim = {
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;

        lsp.enable = true;

        languages = {
          enableTreesitter = true;
          nix = {
            enable = true;
            format = {
              enable = true;
              type = "nixfmt";
            };
          };
        };
      };
    };
  };
}
