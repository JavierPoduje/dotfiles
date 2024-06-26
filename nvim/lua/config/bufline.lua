local g = require("g")
local bufferline = require("bufferline")

bufferline.setup({
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

local bufexec = bufferline.exec

local sweep = function()
	vim.api.nvim_exec(":BufferLineCloseRight", true)
	vim.api.nvim_exec(":BufferLineCloseLeft", true)
end

-- Split the window vertically, focus on the new one and move to `next` or
-- `prev` buffer.
-- @param direction string: `next` or `prev`, determine where to move.
-- @return void
local split_and_move = function(direction)
	return function()
		vim.api.nvim_exec(":vs", true)
		vim.api.nvim_exec(":wincmd l", true)
		if direction == "next" then
			vim.api.nvim_exec(":BufferLineCycleNext", true)
		else
			vim.api.nvim_exec(":BufferLineCyclePrev", true)
		end
	end
end

local close = function(bufnr)
	return function()
		bufexec(bufnr, function(buf)
			vim.cmd("bd!" .. buf.id)
		end)
	end
end

-- Move buffers tabs
vim.keymap.set("n", "<Leader>bn", ":BufferLineMoveNext<CR>", { silent = true })
vim.keymap.set("n", "<Leader>bp", ":BufferLineMovePrev<CR>", { silent = true })

-- Move between buffers
vim.keymap.set("n", "<C-l>", ":BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<C-h>", ":BufferLineCyclePrev<CR>", { silent = true })

-- Move to last buffer
vim.keymap.set("n", "<Leader>#", ":e#<CR>", { silent = true })

vim.api.nvim_create_user_command("Vs", split_and_move("next"), { range = true })
vim.api.nvim_create_user_command("VS", split_and_move("prev"), { range = true })

vim.keymap.set("n", "<Leader>xd", ":bd!<CR>", { silent = true })
vim.keymap.set("n", "<Leader>bd", sweep, { silent = true })

for char, bufnr in pairs(g.num_by_char) do
	-- go to specific buffer
	vim.keymap.set("n", "<Leader>b" .. char, ":BufferLineGoToBuffer " .. bufnr .. "<CR>", { silent = true })
	-- close specific buffer
	vim.keymap.set("n", "<Leader>x" .. char, close(bufnr), { silent = true })
end
