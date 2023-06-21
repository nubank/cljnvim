{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types writeIf mkIf;
  cfg = config.cljnvim.theme;
  git = config.cljnvim.git;
  telescope = config.cljnvim.telescope;
  treesitter = config.cljnvim.treesitter;
  completion = config.cljnvim.completion;
  trouble = config.cljnvim.lsp.trouble;
  which-key = config.cljnvim.ui.which-key;
  illuminate = config.cljnvim.ui.word-highlight;
  indent = config.cljnvim.visuals.indent-blankline;
  lsp = config.cljnvim.lsp;
in {
  options.cljnvim.theme = {
    enable = mkEnableOption "Enable theme customization";
    name = mkOption {
      description = "Name of the theme to use";
      type = types.enum ["catppuccin"];
      default = "catppuccin";
    };
    flavour = {
      dark = mkOption {
        description = "Dark variant of theme style required";
        type = types.enum ["frappe" "macchiato" "mocha"];
      };
      light = mkOption {
        description = "Light variant theme style";
        type = types.nullOr (types.enum ["latte"]);
        default = null;
      };
    };
  };

  config.cljnvim = mkIf cfg.enable {
    startPlugins = with pkgs.neovimPlugins; [theme-catppuccin];
    rawConfig = ''
      			-- CATPPUCCIN THEME
      			require('catppuccin').setup({
      				flavour = "${cfg.flavour.dark}",
      	${writeIf (cfg.flavour.light != null) ''
                background = {
        	light = "${cfg.flavour.light}",
        	dark = "${cfg.flavour.dark}",
        },
      ''}
      	integrations = {
      		${writeIf completion.enable ''
        cmp = true,
      ''}
      		${writeIf git.enable ''
        gitsigns = true,
      ''}
      		${writeIf telescope.enable ''
        telescope = true,
      ''}
      		${writeIf treesitter.enable ''
        treesitter = true,
        ts_rainbow2 = true,
      ''}
      		${writeIf trouble.enable ''
        lsp_trouble = true,
      ''}
      		${writeIf which-key.enable ''
        which_key = true,
      ''}
      		${writeIf illuminate.enable ''
        illuminate = true,
      ''}
      		${writeIf indent.enable ''
        indent_blankline = {
        	enabled = true,
        	colored_indent_levels = false,
        },
      ''}
      		${writeIf lsp.enable ''
        native_lsp = {
        	enabled = true,
        	virtual_text = {
        		errors = { "italic" },
        		hints = { "italic" },
        		warnings = { "italic" },
        		information = { "italic" },
        	},
        	underlines = {
        		errors = { "underline" },
        		hints = { "underline" },
        		warnings = { "underline" },
        		information = { "underline" },
        	},
        },
      ''}
      	},
      })
      vim.cmd('colo catppuccin')
      	-- END CATPPUCCIN THEME
    '';
  };
}
