return {
	"ThePrimeagen/harpoon",
	lazy = false,
	keys = {
		{ "<Leader>ya", ":lua require('harpoon.mark').add_file()<CR>", silent = true },
		{ "<Leader>yt", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", silent = true },
		{ "<C-PageDown>", ":lua require('harpoon.ui').nav_next()<CR>", silent = true },
		{ "<C-PageUp>", ":lua require('harpoon.ui').nav_prev()<CR>", silent = true },
	},
	config = function()
		require("harpoon").setup({
			global_settings = {
				save_on_toggle = false,
				save_on_change = true,
				enter_on_sendcmd = false,
				excluded_filetypes = { "harpoon" },
			},
			menu = {
				width = vim.api.nvim_win_get_width(0) - 10,
			},
		})

		for char, num in pairs(require("g").left_num_by_char) do
			vim.keymap.set(
				"n",
				"<Leader>y" .. char,
				":lua require('harpoon.ui').nav_file(" .. tostring(num) .. ")<CR>",
				{ silent = true, noremap = true }
			)
		end
	end,
}
