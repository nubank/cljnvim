filetype plugin indent on
syntax on

lua << EOF

-- KEYBIDINGS
local map = vim.api.nvim_set_keymap




map("n","-",":lua require('oil').open() <cr>",{noremap = true,})
map("n","<leader>[d","<cmd>lua vim.diagnostic.goto_prev<cr>",{noremap = true,})
map("n","<leader>]d","<cmd>lua vim.diagnostic.goto_next<cr>",{noremap = true,})
map("n","<leader>e","<cmd>lua vim.diagnostic.open_float<cr>",{noremap = true,})
map("n","<leader>fb","<cmd> Telescope buffers<CR>",{noremap = true,})
map("n","<leader>ff","<cmd> Telescope find_files<CR>",{noremap = true,})
map("n","<leader>fg","<cmd> Telescope live_grep<CR>",{noremap = true,})
map("n","<leader>fh","<cmd> Telescope help_tags<CR>",{noremap = true,})
map("n","<leader>flD","<cmd> Telescope lsp_definitions<CR>",{noremap = true,})
map("n","<leader>fld","<cmd> Telescope diagnostics<CR>",{noremap = true,})
map("n","<leader>fli","<cmd> Telescope lsp_implementations<CR>",{noremap = true,})
map("n","<leader>flr","<cmd> Telescope lsp_references<CR>",{noremap = true,})
map("n","<leader>flsb","<cmd> Telescope lsp_document_symbols<CR>",{noremap = true,})
map("n","<leader>flsw","<cmd> Telescope lsp_workspace_symbols<CR>",{noremap = true,})
map("n","<leader>flt","<cmd> Telescope lsp_type_definitions<CR>",{noremap = true,})
map("n","<leader>fs","<cmd> Telescope treesitter<CR>",{noremap = true,})
map("n","<leader>fvb","<cmd> Telescope git_branches<CR>",{noremap = true,})
map("n","<leader>fvcb","<cmd> Telescope git_bcommits<CR>",{noremap = true,})
map("n","<leader>fvcw","<cmd> Telescope git_commits<CR>",{noremap = true,})
map("n","<leader>fvs","<cmd> Telescope git_status<CR>",{noremap = true,})
map("n","<leader>fvx","<cmd> Telescope git_stash<CR>",{noremap = true,})
map("n","<leader>gR","<cmd>Gitsigns reset_buffer<CR>",{noremap = true,})
map("n","<leader>gS","<cmd>Gitsigns stage_buffer<CR>",{noremap = true,})
map("n","<leader>gU","<cmd>Gitsigns reset_buffer_index<CR>",{noremap = true,})
map("n","<leader>gb","<cmd>lua require'gitsigns'.blame_line{full=true}<CR>",{noremap = true,})
map("n","<leader>gp","<cmd>Gitsigns preview_hunk<CR>",{noremap = true,})
map("n","<leader>gr","<cmd>Gitsigns reset_hunk<CR>",{noremap = true,})
map("n","<leader>gs","<cmd>Gitsigns stage_hunk<CR>",{noremap = true,})
map("n","<leader>gtl",":Gitsigns toggle_linehl<CR>",{noremap = true,})
map("n","<leader>gtn",":Gitsigns toggle_numhl<CR>",{noremap = true,})
map("n","<leader>gts",":Gitsigns toggle_signs<CR>",{noremap = true,})
map("n","<leader>gtw",":Gitsigns toggle_word_diff<CR>",{noremap = true,})
map("n","<leader>gu","<cmd>Gitsigns undo_stage_hunk<CR>",{noremap = true,})
map("n","<leader>q","<cmd>lua vim.diagnostic.setloclist<cr>",{noremap = true,})
map("n","<leader>rn",":IncRename ",{noremap = true,})
map("n","<leader>rnc",":lua (':IncRename' .. vim.fn.expand('<cword>'))<cr>",{noremap = true,})
map("n","<leader>xd","<cmd>TroubleToggle document_diagnostics<cr>",{noremap = true,})
map("n","<leader>xl","<cmd>TroubleToggle loclist<cr>",{noremap = true,})
map("n","<leader>xq","<cmd>TroubleToggle quickfix<cr>",{noremap = true,})
map("n","<leader>xw","<cmd>TroubleToggle workspace_diagnostics<cr>",{noremap = true,})
map("n","<leader>xx","<cmd>TroubleToggle<cr>",{noremap = true,})
map("n","gR","<cmd>TroubleToggle lsp_references<cr>",{noremap = true,})

map("v","<leader>gr",":Gitsigns reset_hunk<CR>",{noremap = true,})
map("v","<leader>gs",":Gitsigns stage_hunk<CR>",{noremap = true,})

-- END KEYBIDINGS

-- GLOBALS
vim.g.foldexpr = "nvim_treesitter#foldexpr()"
vim.g.foldmethod = "expr"
vim.g.nofoldenable = 1
-- END GLOBALS

-- AUGROUPS AND AUTOCMDS
local yankhighlight_group = vim.api.nvim_create_augroup("YankHighlight",
	{clear = true}
)
vim.api.nvim_create_autocmd("TextYankPost", {
	command = [[silent! lua vim.highlight.on_yank()]],
	group = yankhighlight_group,
	pattern = "*"
})


-- ENDAUGROUPS AND AUTOCMDS

-- TROUBLE CONFIG
require('trouble').setup({
  auto_preview = false,
})
-- END TROUBLE CONFIG

-- INC RENAME CONFIG
require('inc_rename').setup()
-- END INC RENAME CONFIG

  	 -- NULL LS CONFIG
  	 local null_ls = require('null-ls')
  	 local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  	 local sources = {
  		 null_ls.builtins.diagnostics.clj_kondo.with({
	command = "/nix/store/zy2zi1vapaqikahlikhbwgx9mc92c6yj-clj-kondo-2023.04.14/bin/clj-kondo",
}),
null_ls.builtins.formatting.joker.with({
	command = "/nix/store/wlr0b4b411xjc5bd4xvyy3522g5nlnca-joker-1.1.0/bin/joker"
}),

  		 null_ls.builtins.formatting.dart_format.with({
	command = "/nix/store/sf9x9nc3h91s9a3wgmsyw3i50yic99ml-dart-3.0.0/bin/dart"
}),

null_ls.builtins.formatting.trim_whitespace.with({
 command = "/nix/store/vna5nr2b4270ll9z747pxyimxc4g2brz-gawk-5.2.1/bin/gawk"
}),
null_ls.builtins.diagnostics.hadolint.with({
	command = "/nix/store/mjbx2vkr1qf9b6b7q8wpy47zgfgfb4mi-hadolint-2.12.0/bin/hadolint"
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

-- DART LSP CONFIG
require('lspconfig').dartls.setup({
  capabilities = require("cmp_nvim_lsp").default_capabilities(),

  cmd = {"/nix/store/sf9x9nc3h91s9a3wgmsyw3i50yic99ml-dart-3.0.0/bin/dart", "language-server", "--protocol=lsp"}
})
-- END DART LSP CONFIG

-- CLOJURE LSP CONFIG
require('lspconfig').clojure_lsp.setup({
  capabilities = require("cmp_nvim_lsp").default_capabilities(),

  cmd = {"/nix/store/rskcll0g3xic6fdxks5726s8ylp3yd85-clojure-lsp-2023.05.04-19.38.01/bin/clojure-lsp"},
})
-- END CLOJURE LSP CONFIG

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

  -- TELESCOPE CONFIG
require('telescope').setup({
  defaults = {
 	 vimgrep_arguments = {
 		 "/nix/store/mxan4gz5cw6ghg8p4n421j032cip4krq-silver-searcher-2.2.0/bin/ag",
 		 "--smart-case",
 		 "--nocolor",
 		 "--noheading",
 		 "--column",
 	 },
 	 pickers = {
 		 find_command = { "/nix/store/cblyjqgws1m89lcsar4a9f266s772ksr-fd-8.7.0/bin/fd" }
 	 }
  }
})
  -- END TELESCOPE CONFIG

-- LSP CONFIG
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
-- END LSP CONFIG

-- GITSIGNS
require('gitsigns').setup {
  watch_gitdir = { interval = 100, follow_files = true },
  current_line_blame = true,
  update_debounce = 50,
}
-- END GITSIGNS

-- FILETREE CONFIG
  require("oil").setup({
   	default_file_explorer = true,
   	use_default_keymaps = true,
   	columns = {"icon"};
  })
-- END FILETREE CONFIG

-- NVIM CMP

local luasnip = require("luasnip")
require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  formatting = {
  format = require('lspkind').cmp_format({
    mode = 'symbol',
    maxwidth = 35,
    ellipsis_char = '...',
  }),
},

  snippet = {
  expand = function(args)
    luasnip.lsp_expand(args.body)
  end,
},

  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    -- super tab editing
["<Tab>"] = cmp.mapping(function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expand_or_jumpable() then
  luasnip.expand_or_jump()

  elseif has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end, { "i", "s" }),

["<S-Tab>"] = cmp.mapping(function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
  luasnip.jump(-1)

  else
    fallback()
  end
end, { "i", "s" }),

  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'cmdline' },
    { name = 'luasnip' },
  }),
})

-- END NVIM CMP



EOF