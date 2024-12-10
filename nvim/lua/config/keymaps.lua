local utils = require("utils")
local repeat_str = utils.repeat_str

-- set python3 environment
vim.g.python3_host_prog = "/usr/bin/python3"

-- Multi-cursor exit all cursors by default
vim.g.multi_cursor_quit_key = "<C-c>"

-- CTRL+C for esc
vim.keymap.set("i", "<C-c>", "<ESC><ESC>", { silent = true })

-- more comfortable yanking
vim.keymap.set("n", "<Leader>yy", 'V"+y', { silent = true })
vim.keymap.set("v", "<Leader>yy", '"+y', { silent = true })

-- sort selected lines
vim.keymap.set("v", "<Leader>s", ":sort<cr>", { silent = true })

-- move forward in insert mode
vim.keymap.set("i", "<C-l>", "<Right>", { silent = true })
vim.keymap.set("i", "<C-j>", "<C-o>h", { silent = true })

-- Set space as leader key
vim.keymap.set("n", "<Space>", "<NOP><CR>", { silent = true })

-- Delete front word in insert mode with CTRL+d
vim.keymap.set("i", "<C-D>", "X<Esc>ce", { silent = true })

-- Better search-and-replace for normal and visual modes
vim.keymap.set("n", "<Leader>:", ":%s/<C-R><C-W>/<C-R><C-W>/g" .. repeat_str("<left>", 2), { silent = false })
vim.keymap.set("v", "<Leader>:", ":s//g" .. repeat_str("<left>", 2), { silent = false })

-- Paste but remember
vim.keymap.set("x", "<Leader>fp", '"_dP', { silent = true })

-- Format one long line into multiple short lines
vim.keymap.set("n", "Q", "gq<CR>", { silent = true })

vim.keymap.set("n", "J", "mzJ`z", { silent = true })

-- Toggle wrap
vim.keymap.set("n", "<Leader>ww", ":set wrap! linebreak<CR>", { silent = true })

-- More options for transit from normal to insert mode
vim.keymap.set("n", "<Leader>O", "O<Esc>O", { silent = true })
vim.keymap.set("n", "<Leader>o", "o<CR>", { silent = true })

-- for JS/Typescript, set all "." to "?." in VISUAL MODE
vim.keymap.set("v", "<Leader>?", "<ESC><cmd>'<,'>substitute/\\./?./g<CR>", { silent = true })

-- Better navigation
vim.keymap.set("n", "<Leader>k", ":wincmd k<CR>", { silent = true })
vim.keymap.set("n", "<Leader>l", ":wincmd l<CR>", { silent = true })
vim.keymap.set("n", "<Leader>j", ":wincmd j<CR>", { silent = true })
vim.keymap.set("n", "<Leader>h", ":wincmd h<CR>", { silent = true })

-- Keep it centered
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })

-- Tab handlers
vim.keymap.set("n", "<Leader>tx", ":tabclose<CR>", { silent = true })
vim.keymap.set("n", "<Leader>tn", ":tabn<CR>", { silent = true })
vim.keymap.set("n", "<Leader>tp", ":tabp<CR>", { silent = true })
-- go to tab by number
for char, buff_num in pairs(utils.num_by_char) do
    vim.keymap.set("n", "<Leader>t" .. char, ":tabn" .. buff_num .. "<CR>", { silent = true })
end

-- Better marks
for char, _ in pairs(utils.left_num_by_char) do
    vim.keymap.set("n", "m" .. char, "m" .. char:upper(), { silent = true })
    vim.keymap.set("n", "<Leader>m" .. char, "`" .. char:upper() .. "<CR>", { silent = true })
end

-- More options for paste
vim.keymap.set("n", "<Leader>po", "o<Esc>p", { silent = true })
vim.keymap.set("n", "<Leader>PO", "O<Esc>P", { silent = true })

-- Show undo tree
vim.keymap.set("n", "<Leader>u", ":UndotreeShow<CR>", { silent = true })

-- Source configuration
vim.keymap.set("n", "<Leader><CR>", ":so %<CR>", { silent = false })
vim.keymap.set("v", "<Leader><CR>", ":lua<CR>", { silent = false })

-- Resize windows
vim.keymap.set("n", "<S-Up>", ":resize +5<CR>", { silent = true })
vim.keymap.set("n", "<S-Down>", ":resize -5<CR>", { silent = true })
vim.keymap.set("n", "<S-Right>", ":vertical resize -5<CR>", { silent = true })
vim.keymap.set("n", "<S-Left>", ":vertical resize +5<CR>", { silent = true })

-- Better saving
vim.keymap.set("n", "<Leader>s", ":write<CR>", { silent = true })

-- Better tabbing
vim.keymap.set("v", "<S-Tab>", "<gv", { silent = true })
vim.keymap.set("v", "<Tab>", ">gv", { silent = true })

-- Move visual block up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- By default `W` this calls the fzf's windows preview. I just want to save my file...
vim.api.nvim_command("command! W  write")

-- Netrw
vim.keymap.set("n", "<Leader>pe", ":Vex<CR>", { silent = true })

-- Copy current file path to clipboard
vim.keymap.set("n", "<Leader>%", ":let @+=expand('%')<CR>", { silent = true })

-- display tabs
vim.keymap.set("n", "<Leader>pt", ":tabs<CR>", { silent = true })

-- buffers stuff
-- go to the prev buffer
vim.keymap.set("n", "<Leader>#", ":e#<CR>", { silent = true })
-- close current buffer
vim.keymap.set("n", "<Leader>xd", ":bd!<CR>", { silent = true })
-- Move between buffers
-- move to next buffer
vim.keymap.set("n", "<C-l>", ":bnext<CR>", { silent = true })
-- move to prev buffer
vim.keymap.set("n", "<C-h>", ":bprev<CR>", { silent = true })

-- close current buffer and return to the previous one
-- this is useful for when the window is split and you want to close the
-- current buffer keeping the split
vim.keymap.set("n", "<Leader>xf", function()
    local current_bufnr = vim.fn.bufnr()
    vim.cmd("e#")                        -- go to the previous buffer
    vim.cmd("bdelete " .. current_bufnr) -- close the buffer using the bufnr
end, { desc = "Close current bufer and switch to the previous one", silent = true })

-- quickfix management
vim.keymap.set("n", "<Leader>qo", ":copen<CR>", { silent = true })
vim.keymap.set("n", "<Leader>qc", ":cclose<CR>", { silent = true })
vim.keymap.set("n", "<Leader>ql", ":cnext<CR>", { silent = true })
vim.keymap.set("n", "<Leader>qh", ":cprev<CR>", { silent = true })
