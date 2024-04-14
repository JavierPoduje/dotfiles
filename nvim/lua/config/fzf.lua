vim.g.fzf_layout = { window = { width = 0.8, height = 0.8 } }
vim.g.fzf_colors = {
	fg = { "fg", "Normal" },
	bg = { "bg", "Normal" },
	hl = { "fg", "Comment" },
	info = { "fg", "PreProc" },
	border = { "fg", "Ignore" },
	prompt = { "fg", "Conditional" },
	pointer = { "fg", "Exception" },
	marker = { "fg", "Keyword" },
	spinner = { "fg", "Label" },
	header = { "fg", "Comment" },
}
vim.g.fzf_colors["fg+"] = { "fg", "CursorLine" }
vim.g.fzf_colors["bg+"] = { "bg", "CursorLine", "CursorColumn" }
vim.g.fzf_colors["hl+"] = { "fg", "Statement" }
