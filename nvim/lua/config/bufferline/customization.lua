local M = {}

-- Delete all buffers but the focused one
-- @return void
M.sweep = function()
	vim.api.nvim_exec(":BufferLineCloseRight", true)
	vim.api.nvim_exec(":BufferLineCloseLeft", true)
end

-- Split the window vertically, focus on the new one and move to `next` or
-- `prev` buffer.
-- @param direction string: `next` or `prev`, determine where to move.
-- @return void
M.split_and_move = function(direction)
	vim.api.nvim_exec(":vs", true)
	vim.api.nvim_exec(":wincmd l", true)
	if direction == "next" then
		vim.api.nvim_exec(":BufferLineCycleNext", true)
	else
		vim.api.nvim_exec(":BufferLineCyclePrev", true)
	end
end

M.close_buff_by_num = function(bufnr)
	require("bufferline").exec(bufnr, function(buf)
		vim.cmd("bd!" .. buf.id)
	end)
end

return M
