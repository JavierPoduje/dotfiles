vim.g.NERDCustomDelimiters = {
	javascript = {
		left = "// ",
		right = "",
		leftAlt = "{/* ",
		rightAlt = " */}",
	},
	typescript = {
		left = "// ",
		leftAlt = "/* ",
		rightAlt = " */",
	},
	vue = {
		left = "// ",
		leftAlt = "<!-- ",
		rightAlt = " -->",
	},
	typescriptreact = {
		left = "// ",
		leftAlt = "{/* ",
		rightAlt = " */}",
	},
	php = {
		left = "// ",
		leftAlt = "<!-- ",
		rightAlt = " -->",
	},
}

vim.g.NERDDefaultAlign = "left"

vim.keymap.set("n", "<leader>cp", "Vip:call nerdcommenter#Comment('x', 'toggle')<CR>")
vim.keymap.set("n", "<leader>c}", "V}:call nerdcommenter#Comment('x', 'toggle')<CR>")
vim.keymap.set("n", "<leader>c{", "V{:call nerdcommenter#Comment('x', 'toggle')<CR>")
