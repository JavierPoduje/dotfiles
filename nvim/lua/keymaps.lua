local g = require("g")

-- set python3 environment
vim.g.python3_host_prog = "/usr/bin/python3"

-- Multi-cursor exit all cursors by default
vim.g.multi_cursor_quit_key = "<C-c>"

-- CTRL+C for esc
vim.keymap.set("i", "<C-c>", "<ESC><ESC>")

-- more comfortable yanking
vim.keymap.set("n", "<Leader>yy", 'V"+y')
vim.keymap.set("v", "<Leader>yy", '"+y')

-- sort selected lines
vim.keymap.set("v", "<Leader>s", ":sort<cr>")

-- move forward in insert mode
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<C-o>h")

-- Set space as leader key
vim.keymap.set("n", "<Space>", "<NOP><CR>")

-- Delete front word in insert mode with CTRL+d
vim.keymap.set("i", "<C-D>", "X<Esc>ce")

-- Replace all instances of the word under cursor
vim.keymap.set("n", "<Leader>r", ":%s/<C-r><C-w>//g<Left><Left>")
-- Replace all instances of the word under cursor in visual mode
vim.keymap.set("v", "<Leader>r", ":s/<C-r><C-w>//g<Left><Left>")

-- Paste but remember
vim.keymap.set("x", "<Leader>fp", '"_dP')

-- Format one long line into multiple short lines
vim.keymap.set("n", "Q", "gq<CR>")

vim.keymap.set("n", "J", "mzJ`z")

-- Toggle wrap
vim.keymap.set("n", "<Leader>ww", ":set wrap! linebreak<CR>")

-- More options for transit from normal to insert mode
vim.keymap.set("n", "<Leader>O", "O<Esc>O")
vim.keymap.set("n", "<Leader>o", "o<CR>")

-- for JS/Typescript, set all "." to "?." in VISUAL MODE
vim.keymap.set("v", "<Leader>?", "<ESC><cmd>'<,'>substitute/\\./?./g<CR>")

-- Better navigation
vim.keymap.set("n", "<Leader>k", ":wincmd k<CR>")
vim.keymap.set("n", "<Leader>l", ":wincmd l<CR>")
vim.keymap.set("n", "<Leader>j", ":wincmd j<CR>")
vim.keymap.set("n", "<Leader>h", ":wincmd h<CR>")

-- Keep it centered
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Tab handlers
vim.keymap.set("n", "<Leader>tx", ":tabclose<CR>")
vim.keymap.set("n", "<Leader>tn", ":tabn<CR>")
vim.keymap.set("n", "<Leader>tp", ":tabp<CR>")
-- go to tab by number
for char, buff_num in pairs(g.num_by_char) do
	vim.keymap.set("n", "<Leader>t" .. char, ":tabn" .. buff_num .. "<CR>")
end

-- Better marks
for char, _ in pairs(g.left_num_by_char) do
	vim.keymap.set("n", "m" .. char, "m" .. char:upper())
	vim.keymap.set("n", "<Leader>m" .. char, "`" .. char:upper() .. "<CR>")
end

-- Navigate quickfix list
vim.keymap.set("n", "<Leader>cl", ":cnext<CR>")
vim.keymap.set("n", "<Leader>ch", ":cprev<CR>")

-- More options for paste
vim.keymap.set("n", "<Leader>po", "o<Esc>p")
vim.keymap.set("n", "<Leader>PO", "O<Esc>P")

-- Show undo tree
vim.keymap.set("n", "<Leader>u", ":UndotreeShow<CR>")

-- Source configuration
vim.keymap.set("n", "<Leader><CR>", ":so %<CR>", { noremap = true, silent = false })

-- Resize windows
vim.keymap.set("n", "<S-Up>", ":resize +5<CR>")
vim.keymap.set("n", "<S-Down>", ":resize -5<CR>")
vim.keymap.set("n", "<S-Right>", ":vertical resize -5<CR>")
vim.keymap.set("n", "<S-Left>", ":vertical resize +5<CR>")

-- Better saving
vim.keymap.set("n", "<Leader>s", ":write<CR>")

-- Better tabbing
vim.keymap.set("v", "<S-Tab>", "<gv")
vim.keymap.set("v", "<Tab>", ">gv")

-- Move visual block up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- By default `W` this calls the fzf's windows preview. I just want to save my file...
v.nvim_command("command! W  write")

-- Netrw
vim.keymap.set("n", "<Leader>pe", ":Vex<CR>")
