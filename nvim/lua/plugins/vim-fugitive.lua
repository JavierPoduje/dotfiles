return {
	"tpope/vim-fugitive",
	keys = {
		{ "<Leader>gl", ":diffget //3<CR>", silent = true },
		{ "<Leader>gh", ":diffget //2<CR>", silent = true },
		{ "<Leader>gs", ":G<CR>", silent = true },
		{ "<Leader>gb", ":Git blame<CR>", silent = true },
		{ "<Leader>gp", ":GitGutterPreviewHunk<CR>", silent = true },
	},
	config = function() end,
}
