{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf writeIf;
  cfg = config.cljnvim.languages.clojure;
  lsp = cfg.enable && cfg.lsp.enable;
  completion = config.cljnvim.completion.enable && cfg.enable;
in {
  options.cljnvim.languages.clojure = {
    enable = mkEnableOption "Enables Clojure support plugins";
    lsp.enable = mkEnableOption "Enables Clojure LSP";
  };

  config.cljnvim = mkIf cfg.enable {
    startPlugins = with pkgs.neovimPlugins; [conjure vim-sexp vim-sexp-mappings];
    rawConfig = mkIf lsp ''
      -- CLOJURE LSP CONFIG
      require('lspconfig').clojure_lsp.setup({
        ${writeIf completion ''
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      ''}
        cmd = {"${pkgs.clojure-lsp}/bin/clojure-lsp"},
      })
      -- END CLOJURE LSP CONFIG
    '';
  };
}
