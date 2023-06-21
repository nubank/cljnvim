{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cljnvim.filetree;
in {
  options.cljnvim.filetree.enable = mkEnableOption "Enables modern file tree and file management";

  config.cljnvim = mkIf (cfg.enable) {
    startPlugins = with pkgs.neovimPlugins; [oil-nvim];
    nnoremap = {
      "-" = ":lua require('oil').open() <cr>";
    };
    rawConfig = ''
      -- FILETREE CONFIG
        require("oil").setup({
         	default_file_explorer = true,
         	use_default_keymaps = true,
         	columns = {"icon"};
        })
      -- END FILETREE CONFIG
    '';
  };
}
