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

vim.cmd.colorscheme("catppuccin")
