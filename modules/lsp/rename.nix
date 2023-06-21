{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cljnvim.lsp;
  rename = cfg.enable && cfg.rename.enable;
in {
  options.cljnvim.lsp.rename.enable = mkEnableOption "Enables LSP rename plugins";

  config.cljnvim = mkIf rename {
    startPlugins = with pkgs.neovimPlugins; [inc-rename];
    nnoremap = {
      "<leader>rn" = ":IncRename ";
      "<leader>rnc" = ":lua (':IncRename' .. vim.fn.expand('<cword>'))<cr>";
    };
    rawConfig = ''
      -- INC RENAME CONFIG
      require('inc_rename').setup()
      -- END INC RENAME CONFIG
    '';
  };
}
