local g = require("g")

require("harpoon").setup({
	global_settings = {
		save_on_toggle = false,
		save_on_change = true,
		enter_on_sendcmd = false,
		excluded_filetypes = { "harpoon" },
	},
	--menu = {
	--  width = vim.api.nvim_win_get_width(0) - 20,
	--},
})

-- add file
vim.keymap.set("n", "<Leader>ya", ":lua require('harpoon.mark').add_file()<CR>", { silent = true, noremap = true })

-- toggle ui
vim.keymap.set(
	"n",
	"<Leader>yt",
	":lua require('harpoon.ui').toggle_quick_menu()<CR>",
	{ silent = true, noremap = true }
)

-- navigate
vim.keymap.set("n", "<Leader>yn", ":lua require('harpoon.ui').nav_next()<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-PageDown>", ":lua require('harpoon.ui').nav_next()<CR>", { silent = true, noremap = true })

vim.keymap.set("n", "<Leader>yp", ":lua require('harpoon.ui').nav_prev()<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-PageUp>", ":lua require('harpoon.ui').nav_prev()<CR>", { silent = true, noremap = true })

for char, num in pairs(g.left_num_by_char) do
	vim.keymap.set(
		"n",
		"<Leader>y" .. char,
		":lua require('harpoon.ui').nav_file(" .. tostring(num) .. ")<CR>",
		{ silent = true, noremap = true }
	)
end
