return {
	"kdheepak/lazygit.nvim",
	config = function()
		vim.g.lazygit_floating_window_scaling_factor = 1
		vim.keymap.set("n", "<Leader>fg", ":LazyGit<CR>")
	end,
}
