return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = { "nvim-treesitter/playground" },
	config = function()
		require("nvim-treesitter.configs").setup({
			additional_vim_regex_highlighting = true,
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"css",
				"git_rebase",
				"go",
				"gotmpl",
				"html",
				"javascript",
				"json",
				"lua",
				"php",
				"prisma",
				"scss",
				"templ",
				"tsx",
				"twig",
				"typescript",
				"vue",
				"yaml",
			},
			query_linter = {
				enable = true,
				use_virtual_text = true,
				lint_events = { "BufWrite", "CursorHold" },
			},
		})
	end,
}
