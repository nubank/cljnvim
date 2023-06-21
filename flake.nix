{
  description = "A minimalist neovim config for developing in Clojure and BDC, with sane defaults";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";

    # Plugins
    conjure = {
      url = "github:Olical/conjure";
      flake = false;
    };

    friendly-snippets = {
      url = "github:rafamadriz/friendly-snippets";
      flake = false;
    };

    gitsigns-nvim = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };

    inc-rename = {
      url = "github:smjonas/inc-rename.nvim";
      flake = false;
    };

    lspkind = {
      url = "github:onsails/lspkind.nvim";
      flake = false;
    };

    luasnip = {
      url = "github:L3MON4D3/LuaSnip";
      flake = false;
    };

    nvim-cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };

    nvim-cmp-buffer = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };

    nvim-cmp-cmdline = {
      url = "github:hrsh7th/cmp-cmdline";
      flake = false;
    };

    nvim-cmp-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };

    nvim-cmp-luasnip = {
      url = "github:saadparwaiz1/cmp_luasnip";
      flake = false;
    };

    nvim-cmp-path = {
      url = "github:hrsh7th/cmp-path";
      flake = false;
    };

    nvim-lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };

    nvim-ts-autotag = {
      url = "github:windwp/nvim-ts-autotag";
      flake = false;
    };

    nvim-ts-context = {
      url = "github:nvim-treesitter/nvim-treesitter-context";
      flake = false;
    };

    nvim-ts-rainbow = {
      url = "github:HiPhish/nvim-ts-rainbow2";
      flake = false;
    };

    null-ls = {
      url = "github:jose-elias-alvarez/null-ls.nvim";
      flake = false;
    };

    plenary-nvim = {
      url = "github:nvim-lua/plenary.nvim/v0.1.3";
      flake = false;
    };

    telescope-nvim = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };

    theme-catppuccin = {
      url = "github:catppuccin/nvim/v1.2.0";
      flake = false;
    };

    trouble-nvim = {
      url = "github:folke/trouble.nvim";
      flake = false;
    };

    oil-nvim = {
      url = "github:stevearc/oil.nvim";
      flake = false;
    };

    vim-sexp = {
      url = "github:guns/vim-sexp";
      flake = false;
    };

    vim-sexp-mappings = {
      url = "github:tpope/vim-sexp-mappings-for-regular-people";
      flake = false;
    };
  };

  outputs = {
    flake-utils,
    nixpkgs,
    self,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system overlays;};
      lib = import ./lib.nix {inherit pkgs inputs;};
      inherit (import ./default_config.nix) config;
      inherit (import ./overlays.nix {inherit lib;}) overlays;
    in rec {
      apps = rec {
        neovim = {
          type = "app";
          program = "${self.packages.default}/bin/nvim";
        };
        default = neovim;
      };

      packages = rec {
        default = cljnvim;
        cljnvim = lib.mkNeovim {inherit config;};
      };

      overlays.default = _super: _self: {
        inherit (lib) mkNeovim;
        inherit (pkgs) neovimPlugins;
        inherit (packages) cljnvim;
      };
    });
}
