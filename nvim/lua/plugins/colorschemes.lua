return {
	{
		"savq/melange-nvim",
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			local flavour = "mocha" -- macchiato, mocha, frappe, latte
			local colors = require("catppuccin.palettes").get_palette(flavour)

			require("catppuccin").setup({
				flavour = flavour,
				styles = { comments = { "italic" }, conditionals = { "italic" } },
				term_colors = true,
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					telescope = true,
					treesitter = true,
					treesitter_context = true,
				},
				transparent_background = false,
				custom_highlights = {
					Comment = { fg = colors.overlay1 },
					TreesitterContextLineNumber = { fg = colors.sky },
					LineNr = { fg = colors.overlay0 },
					CursorLineNr = { fg = colors.sky, style = { "bold" } },
				},
			})

			-- TODO: investigate what's the right place for setting the colorscheme
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"sainnhe/gruvbox-material",
		config = function()
			vim.g.gruvbox_material_palette = "material" -- 'material' | 'mix' | 'original'

			vim.g.gruvbox_material_background = "hard" -- 'hard' | 'medium' (default) | 'soft'

			-- Set transparent background
			vim.g.gruvbox_material_transparent_background = 0
			vim.g.gruvbox_material_enable_bold = 1

			--vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	{
		"pineapplegiant/spaceduck",
		config = function()
			--vim.cmd("colorscheme spaceduck")
		end,
	},
	{
		"rose-pine/neovim",
		config = function()
			require("rose-pine").setup({
				variant = "moon", -- auto, main, moon, or dawn
				dark_variant = "moon", -- main, moon, or dawn
				styles = {
					bold = true,
					italic = true,
					transparency = false,
				},
			})
			--vim.cmd("colorscheme rose-pine-moon")
		end,
	},
	{
		"miikanissi/modus-themes.nvim",
	},
	{
		-- currently broken
		"comfysage/evergarden",
		opts = {
			style = {
				sign = {},
			},
			transparent_background = false,
			contrast_dark = "hard", -- 'hard'|'medium'|'soft'
			overrides = {}, -- add custom overrides
		},
	},
	{
		"ayu-theme/ayu-vim",
		config = function()
			-- "light"
			-- "mirage"
			-- "dark"
			vim.g.ayucolor = "dark"
			--vim.cmd("colorscheme ayu")
		end,
	},
	{
		"vague2k/vague.nvim",
		config = function()
			require("vague").setup({
				--vim.cmd.colorscheme("vague")
			})
		end,
	},
}
