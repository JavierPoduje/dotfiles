local g = require("g")

require("bufferline").setup({
	options = {
		numbers = function(opts)
			return string.format("%s", opts.raise(opts.ordinal))
		end,
		BufferLineGoToBuffer = false,
		indicator = {
			style = "icon",
		},
		modified_icon = "●",
		left_trunc_marker = "",
		right_trunc_marker = "",
		name_formatter = function(buf)
			if buf.name:match("%.md") then
				return vim.fn.fnamemodify(buf.name, ":t:r")
			end
		end,
		max_name_length = 18,
		max_prefix_length = 15,
		tab_size = 18,
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count)
			return " (" .. count .. ")"
		end,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "center",
			},
		},
		show_buffer_icons = true,
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_tab_indicators = true,
		persist_buffer_sort = true,
		separator_style = { " ", " " }, -- "slant" | "thick" | "thin"
		enforce_regular_tabs = false, -- false | true,
		always_show_bufferline = true,
		sort_by = "id",
	},
})

-- Move buffers tabs
vim.keymap.set("n", "<Leader>bn", ":BufferLineMoveNext<CR>")
vim.keymap.set("n", "<Leader>bp", ":BufferLineMovePrev<CR>")

-- Move between buffers
vim.keymap.set("n", "<C-l>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<C-h>", ":BufferLineCyclePrev<CR>")

-- Move to last buffer
vim.keymap.set("n", "<Leader>#", ":e#<CR>")

-- Open next/previous buffer on the right using vertical split
local M = "require'config.bufferline.customization'"

v.nvim_command("command! Vs :lua " .. M .. ".split_and_move('next')")
v.nvim_command("command! VS :lua " .. M .. ".split_and_move('prev')")

vim.keymap.set("n", "<Leader>xd", ":bd!<CR>")
vim.keymap.set("n", "<Leader>bd", ":lua " .. M .. ".sweep()<CR>")

for char, buff_num in pairs(g.num_by_char) do
	-- go to specific buffer
	vim.keymap.set("n", "<Leader>b" .. char, ":BufferLineGoToBuffer " .. buff_num .. "<CR>")
	-- close specific buffer
	vim.keymap.set("n", "<Leader>x" .. char, ":lua " .. M .. ".close_buff_by_num(" .. buff_num .. ")<CR>")
end
