local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Beautification
	"ryanoasis/vim-devicons",
	"kyazdani42/nvim-web-devicons",

	-- Git management
	"tpope/vim-fugitive",
	"airblade/vim-gitgutter",
	"kdheepak/lazygit.nvim",

	-- Co-pilot
	"github/copilot.vim",

	-- LSP
	"jose-elias-alvarez/null-ls.nvim",
	"neovim/nvim-lspconfig",
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
	},

	-- Syntax highlight
	"neoclide/jsonc.vim",
	"nvim-treesitter/nvim-treesitter-context",
	"norcalli/nvim-colorizer.lua",
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = { "nvim-treesitter/playground" },
	},

	-- Files management
	"akinsho/nvim-bufferline.lua",
	"nvim-lualine/lualine.nvim",
	"mbbill/undotree",
	"mhinz/vim-startify",
	"javierpoduje/taboo",

	-- Text management
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"onsails/lspkind-nvim",
			"roginfarrer/cmp-css-variables",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	"jiangmiao/auto-pairs",
	"tpope/vim-surround",
	"preservim/nerdcommenter",
	"mattn/emmet-vim",
	"mhartington/formatter.nvim",
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		dependencies = { "honza/vim-snippets" },
	},

	-- Searchers
	"jremmen/vim-ripgrep",
	"kyazdani42/nvim-tree.lua",
	"ThePrimeagen/harpoon",
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-telescope/telescope-fzy-native.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{ "romgrk/fzy-lua-native" },
			{ "sharkdp/fd" },
		},
	},

	-- colorschemes
	"sainnhe/gruvbox-material",
	{ "catppuccin/nvim", name = "catppuccin" },

	-- Others
	"vuciv/vim-bujo",
	"nvim-lua/plenary.nvim",
})
