vim.env.CC = "gcc"
vim.env.CXX = "g++"

vim.pack.add({
	"https://www.github.com/lewis6991/gitsigns.nvim",
	"https://www.github.com/echasnovski/mini.nvim",
	"https://www.github.com/ibhagwan/fzf-lua",
	"https://www.github.com/nvim-tree/nvim-tree.lua",
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},
	-- Language Server Protocols
	"https://www.github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/creativenull/efmls-configs-nvim",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/hrsh7th/cmp-cmdline",
	"https://github.com/saadparwaiz1/cmp_luasnip",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/obsidian-nvim/obsidian.nvim",
	"https://github.com/mfussenegger/nvim-jdtls",
  "https://github.com/linux-cultist/venv-selector.nvim",

})

require("core.autocmd")
require("core.keymaps")
require("core.option")
require("core.terminal")
require("core.neovide")
require("lsp.jdtls")
require("lsp.lsp")
require("plugins.fzf")
require("plugins.gitsign")
require("plugins.mason")
require("plugins.mini")
require("plugins.nvim-tree")
require("plugins.obsidian")
require("plugins.tree-sitter")
require("plugins.pyvenv")
require("ui.ui")
require("ui.colorscheme")
