{
  description = "A minimalist neovim config for developing in Clojure and BDC, with sane defaults";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    flake-utils,
    nixpkgs,
    self,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system overlays;};
      lib = import ./lib.nix {inherit pkgs plugins;};
      inherit (import ./plugins.nix) plugins;
      inherit (import ./overlays.nix {inherit lib;}) overlays;

      config = {};
    in rec {
      apps = rec {
        neovim = {
          type = "app";
          program = "${self.packages.default}/bin/nvim";
        };
        default = neovim;
      };

      packages = rec {
        default = mnvim;
        mnvim = lib.mkNeovim {inherit config;};
      };

      overlays.default = _super: _self: {
        inherit (lib) mkNeovim;
        inherit (pkgs) neovimPlugins;
        inherit (packages) mnvim;
      };
    });
}
