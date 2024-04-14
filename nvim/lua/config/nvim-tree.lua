local COLS = vim.o.columns
local ROWS = vim.o.lines

local float_window_width = math.floor(COLS / 2)
local float_window_height = math.floor(ROWS / 1.5)

local function opts(desc, bufnr)
	return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end

require("nvim-tree").setup({
	sort_by = "case_sensitive",
	update_focused_file = {
		ignore_list = { "*.pyc" },
	},
	on_attach = function(bufnr)
		local api = require("nvim-tree.api")
		vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab", bufnr))
		vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open", bufnr))
		vim.keymap.set("n", "<ESC>", api.tree.close, opts("Close", bufnr))
		vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview", bufnr))
		vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory", bufnr))
		vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path", bufnr))
		vim.keymap.set("n", "a", api.fs.create, opts("Create", bufnr))
		vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy", bufnr))
		vim.keymap.set("n", "d", api.fs.remove, opts("Delete", bufnr))
		vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help", bufnr))
		vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path", bufnr))
		vim.keymap.set("n", "p", api.fs.paste, opts("Paste", bufnr))
		vim.keymap.set("n", "r", api.fs.rename, opts("Rename", bufnr))
		vim.keymap.set("n", "s", api.node.open.vertical, opts("Open: Vertical Split", bufnr))
		vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Horizontal Split", bufnr))
		vim.keymap.set("n", "x", api.fs.cut, opts("Cut", bufnr))
	end,
	view = {
		side = "left",
		width = 50,
		number = true,
		relativenumber = true,
		float = {
			enable = false,
			open_win_config = {
				relative = "editor",
				border = "rounded",
				width = float_window_width,
				height = float_window_height,
				row = math.floor(((ROWS - float_window_height) / 2) - 1),
				col = math.floor((COLS - float_window_width) / 2),
			},
		},
	},
})

vim.g.nvim_tree_indent_markers = 1

vim.keymap.set("n", "<leader>pv", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>R", ":NvimTreeRefresh<CR>")
vim.keymap.set("n", "<leader>pp", ":NvimTreeFindFileToggle<CR>")
