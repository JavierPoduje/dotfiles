require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
	lspconfig = {
		lua = "lua",
	},
})

require("mason-lspconfig").setup({
	ensure_installed = { "tsserver", "eslint", "html", "cssls" },
})
