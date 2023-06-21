{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf writeIf;
  cfg = config.cljnvim.languages.dart;
  lsp = cfg.enable && cfg.lsp.enable;
  completion = config.cljnvim.completion.enable && cfg.enable;
in {
  options.cljnvim.languages.dart = {
    enable = mkEnableOption "Enables Dart support plugins";
    lsp.enable = mkEnableOption "Enables Dart LSP";
  };

  config.cljnvim = mkIf cfg.enable {
    rawConfig = mkIf lsp ''
      -- DART LSP CONFIG
      require('lspconfig').dartls.setup({
        ${writeIf completion ''
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      ''}
        cmd = {"${pkgs.dart}/bin/dart", "language-server", "--protocol=lsp"}
      })
      -- END DART LSP CONFIG
    '';
  };
}
