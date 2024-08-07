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
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = { "nvim-treesitter/playground" },
	},

	-- Files management
	"akinsho/bufferline.nvim",
	"nvim-lualine/lualine.nvim",
	"mbbill/undotree",
	"mhinz/vim-startify",
	{
		-- TODO: implement winlayout
		"javierpoduje/taboo",
		--dev = true,
	},

	-- Text management
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"onsails/lspkind-nvim",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	{
		"javierpoduje/cmp-css-variables",
		--dev = true,
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
			{ "catgoose/telescope-helpgrep.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-telescope/telescope-fzy-native.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{ "romgrk/fzy-lua-native" },
			{ "sharkdp/fd" },
		},
	},

	-- colorschemes
	"rose-pine/neovim",
	"pineapplegiant/spaceduck",
	"sainnhe/gruvbox-material",
	{ "catppuccin/nvim", name = "catppuccin" },

	-- Others
	"javierpoduje/kamelbab",
	"laytan/cloak.nvim",
	"nvim-lua/plenary.nvim",
	"vuciv/vim-bujo",
})
