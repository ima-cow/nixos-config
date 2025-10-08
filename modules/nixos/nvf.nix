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

        options = {
          expandtab = true;
          smartindent = true;
          tabstop = 2;
          shiftwidth = 2;
        };

        lsp.enable = true;
        languages = {
          enableTreesitter = true;
          enableFormat = true;
          nix = {
            enable = true;
          };
        };
      };
    };
  };
}
