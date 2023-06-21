{
  config.cljnvim = {
    completion = {
      enable = true;
      buffer.enable = true;
      cmdline.enable = true;
      lsp = {
        enable = true;
        lspkind.enable = true;
      };
      path.enable = true;
      snippets.enable = true;
    };
    filetree.enable = true;
    git.enable = true;
    languages = {
      clojure = {
        enable = true;
        lsp.enable = true;
      };
      dart = {
        enable = true;
        lsp.enable = true;
      };
    };
    lsp = {
      enable = true;
      null-ls.enable = true;
      trouble.enable = true;
      rename.enable = true;
    };
    # surround.enable = true;
    telescope.enable = true;
    /*
       theme = {
      enable = true;
      name = "catppuccin";
      flavour = {
        dark = "frappe";
        light = "latte";
      };
    };
    */
    treesitter = {
      enable = true;
      grammars = ["clojure" "dart" "dockerfile" "graphql" "json" "markdown"];
    };
    /*
       ui = {
      enable = true;
      icons.enable = true;
      indent-blankline.enable = true;
      word-highlight.enable = true;
      semantic-highlight.enable = true;
      which-key.enable = true;
    };
    */
  };
}
