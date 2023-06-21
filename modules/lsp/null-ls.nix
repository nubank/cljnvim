{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf writeIf;
  cfg = config.cljnvim.lsp;
  lang = config.cljnvim.languages;
  nullls = cfg.enable && cfg.null-ls.enable;
  clojure = cfg.enable && lang.clojure.enable && lang.clojure.lsp.enable;
  dart = cfg.enable && lang.dart.enable && lang.dart.lsp.enable;
in {
  options.cljnvim.lsp.null-ls.enable = mkEnableOption "Extends Neovim LSP support plugins";

  config.cljnvim = mkIf nullls {
    startPlugins = with pkgs.neovimPlugins; [null-ls];
    rawConfig = ''
        	 -- NULL LS CONFIG
        	 local null_ls = require('null-ls')
        	 local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        	 local sources = {
        		 ${writeIf clojure ''
        null_ls.builtins.diagnostics.clj_kondo.with({
        	command = "${pkgs.clj-kondo}/bin/clj-kondo",
        }),
        null_ls.builtins.formatting.joker.with({
        	command = "${pkgs.joker}/bin/joker"
        }),
      ''}
        		 ${writeIf dart ''
        null_ls.builtins.formatting.dart_format.with({
        	command = "${pkgs.dart}/bin/dart"
        }),
      ''}
      null_ls.builtins.formatting.trim_whitespace.with({
       command = "${pkgs.gawk}/bin/gawk"
      }),
      null_ls.builtins.diagnostics.hadolint.with({
      	command = "${pkgs.hadolint}/bin/hadolint"
      }),
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.completion.luasnip,

        }
        null_ls.setup({
        	sources = sources,
        	on_attach = function(client, bufnr)
        					if client.supports_method("textDocument/formatting") then
        							vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        							vim.api.nvim_create_autocmd("BufWritePre", {
        									group = augroup,
        									buffer = bufnr,
        									callback = function()
        											vim.lsp.buf.format({ bufnr = bufnr })
        											-- vim.lsp.buf.formatting_sync()
        									end,
        							})
        					end
        			end
        })
        	 -- END NULL LS CONFIG
    '';
  };
}
