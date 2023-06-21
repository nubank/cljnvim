{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.cljnvim.git;
in {
  options.cljnvim.git.enable = mkEnableOption "Enable git managent and visuals";

  config.cljnvim = mkIf cfg.enable {
    startPlugins = with pkgs.neovimPlugins; [gitsigns-nvim];
    nnoremap = {
      "<leader>gs" = "<cmd>Gitsigns stage_hunk<CR>";
      "<leader>gu" = "<cmd>Gitsigns undo_stage_hunk<CR>";
      "<leader>gr" = "<cmd>Gitsigns reset_hunk<CR>";
      "<leader>gR" = "<cmd>Gitsigns reset_buffer<CR>";
      "<leader>gp" = "<cmd>Gitsigns preview_hunk<CR>";
      "<leader>gb" = "<cmd>lua require'gitsigns'.blame_line{full=true}<CR>";
      "<leader>gS" = "<cmd>Gitsigns stage_buffer<CR>";
      "<leader>gU" = "<cmd>Gitsigns reset_buffer_index<CR>";
      "<leader>gts" = ":Gitsigns toggle_signs<CR>";
      "<leader>gtn" = ":Gitsigns toggle_numhl<CR>";
      "<leader>gtl" = ":Gitsigns toggle_linehl<CR>";
      "<leader>gtw" = ":Gitsigns toggle_word_diff<CR>";
    };
    vnoremap = {
      "<leader>gr" = ":Gitsigns reset_hunk<CR>";
      "<leader>gs" = ":Gitsigns stage_hunk<CR>";
    };
    # add more config opts...
    rawConfig = ''
      -- GITSIGNS
      require('gitsigns').setup {
        keymaps = { noremap = true },
        watch_gitdir = { interval = 100, follow_files = true },
        current_line_blame = true,
        update_debounce = 50,
      }
      -- END GITSIGNS
    '';
  };
}
