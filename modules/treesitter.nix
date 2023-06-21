{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (pkgs) neovimPlugins;
  inherit (pkgs.vimPlugins) nvim-treesitter;
  inherit (lib) mkEnableOption mkIf mkOption types;
  cfg = config.cljnvim.treesitter;
  mapPluginGrammars = grammars: nvim-treesitter.withPlugins (p: map (g: p.${g}) grammars);
in {
  options.cljnvim.treesitter = {
    grammars = mkOption {
      description = "Grammars packages";
      type = types.listOf types.str;
      default = [];
    };
    enable = mkEnableOption "Enables tree-sitter [nvim-treesitter]";
  };

  config.cljnvim = mkIf cfg.enable {
    startPlugins = with neovimPlugins; [
      nvim-ts-autotag
      nvim-ts-context
      nvim-ts-rainbow
      (mapPluginGrammars cfg.grammars)
    ];
    globals = {
      "foldmethod" = "expr";
      "foldexpr" = "nvim_treesitter#foldexpr()";
      "nofoldenable" = 1;
    };
    rawConfig = ''
      -- TRESSITTER
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
          use_languagetree = true,
        },
        rainbow = {
          enable = true,
          query = 'rainbow-parens',
          strategy = require('ts-rainbow').strategy.global,
        },
        autotag = {
          enable = true,
        },
      })

        require'treesitter-context'.setup {
          enable = true,
          throttle = true,
          max_lines = 0
        }
      -- END TRESSITTER
    '';
  };
}
