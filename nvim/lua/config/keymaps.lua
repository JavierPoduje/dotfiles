local utils = require("utils")

local left_num_by_char = utils.left_num_by_char
local num_by_char = utils.num_by_char
local repeat_str = utils.repeat_str

-- Multi-cursor exit all cursors by default
vim.g.multi_cursor_quit_key = "<C-c>"

-- CTRL+C for esc
vim.keymap.set("i", "<C-c>", "<ESC><ESC>", { silent = true })

-- sort selected lines
vim.keymap.set("v", "<leader>s", ":sort | w<cr>")

-- move forward in insert mode
vim.keymap.set("i", "<C-l>", "<Right>", { silent = true })
vim.keymap.set("i", "<C-j>", "<C-o>h", { silent = true })

-- Set space as leader key
vim.keymap.set("n", "<Space>", "<NOP><CR>", { silent = true })

-- Delete front word in insert mode with CTRL+d
vim.keymap.set("i", "<C-D>", "X<Esc>ce", { silent = true })

-- Better search-and-replace for normal and visual modes
vim.keymap.set("n", "<leader>:", ":%s/<C-R><C-W>/<C-R><C-W>/g" .. repeat_str("<left>", 2))
vim.keymap.set("v", "<leader>:", ":s//g" .. repeat_str("<left>", 2))

-- Paste but remember
vim.keymap.set("x", "<leader>fp", '"_dP', { silent = true })

-- Format one long line into multiple short lines
vim.keymap.set("n", "Q", "gq<CR>", { silent = true })

vim.keymap.set("n", "J", "mzJ`z", { silent = true })

-- Toggle wrap
vim.keymap.set("n", "<leader>ww", ":set wrap! linebreak<CR>", { silent = true })

-- More options for transit from normal to insert mode
vim.keymap.set("n", "<leader>O", "O<Esc>O", { silent = true })
vim.keymap.set("n", "<leader>o", "o<CR>", { silent = true })

-- for JS/Typescript, set all "." to "?." in VISUAL MODE
vim.keymap.set("v", "<leader>?", "<ESC><cmd>'<,'>substitute/\\./?./g<CR>", { silent = true })

-- Better navigation
vim.keymap.set("n", "<leader>k", ":wincmd k<CR>", { silent = true })
vim.keymap.set("n", "<leader>l", ":wincmd l<CR>", { silent = true })
vim.keymap.set("n", "<leader>j", ":wincmd j<CR>", { silent = true })
vim.keymap.set("n", "<leader>h", ":wincmd h<CR>", { silent = true })

-- Keep it centered
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })

-- Tab handlers
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", { silent = true })
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", { silent = true })
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", { silent = true })
-- go to tab by number
for char, buff_num in pairs(num_by_char) do
    vim.keymap.set("n", "<leader>t" .. char, ":tabn" .. buff_num .. "<CR>", { silent = true })
end

-- Better marks
for char, _ in pairs(left_num_by_char) do
    vim.keymap.set("n", "m" .. char, "m" .. char:upper(), { silent = true })
    vim.keymap.set("n", "<leader>m" .. char, "`" .. char:upper() .. "<CR>", { silent = true })
end

-- More options for paste
vim.keymap.set("n", "<leader>po", "o<Esc>p", { silent = true })
vim.keymap.set("n", "<leader>PO", "O<Esc>P", { silent = true })

-- Show undo tree
vim.keymap.set("n", "<leader>u", ":UndotreeShow<CR>", { silent = true })

-- Source configuration
vim.keymap.set("n", "<leader><CR>", ":so %<CR>", { silent = false })
vim.keymap.set("v", "<leader><CR>", ":lua<CR>", { silent = false })

-- Resize windows
vim.keymap.set("n", "<S-Up>", ":resize +5<CR>", { silent = true })
vim.keymap.set("n", "<S-Down>", ":resize -5<CR>", { silent = true })
vim.keymap.set("n", "<S-Right>", ":vertical resize -5<CR>", { silent = true })
vim.keymap.set("n", "<S-Left>", ":vertical resize +5<CR>", { silent = true })

-- Better saving
vim.keymap.set("n", "<leader>s", ":write<CR>", { silent = true })

-- Better tabbing
vim.keymap.set("v", "<S-Tab>", "<gv", { silent = true })
vim.keymap.set("v", "<Tab>", ">gv", { silent = true })

-- Move visual block up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- By default `W` this calls the fzf's windows preview. I just want to save my file...
vim.api.nvim_command("command! W  write")

-- Netrw
vim.keymap.set("n", "<leader>pe", ":Vex<CR>", { silent = true })

-- Copy current file path to clipboard
vim.keymap.set("n", "<leader>%", ":let @+=expand('%')<CR>", { silent = true })

-- display tabs
vim.keymap.set("n", "<leader>pt", ":tabs<CR>", { silent = true })

-- buffers stuff
-- go to the prev buffer
vim.keymap.set("n", "<leader>#", ":e#<CR>", { silent = true })
-- close current buffer
vim.keymap.set("n", "<leader>xd", ":bd!<CR>", { silent = true })
-- Move between buffers
-- move to next buffer
vim.keymap.set("n", "<C-l>", ":bnext<CR>", { silent = true })
-- move to prev buffer
vim.keymap.set("n", "<C-h>", ":bprev<CR>", { silent = true })

-- close current buffer and return to the previous one
-- this is useful for when the window is split and you want to close the
-- current buffer keeping the split
vim.keymap.set("n", "<leader>xf", function()
    -- save the current buffer before moving to the previous one
    local current_bufnr = vim.fn.bufnr()
    -- go to the previous buffer
    vim.cmd("e#")
    -- close the buffer using the bufnr
    vim.cmd("bdelete " .. current_bufnr)
end, { desc = "Close current bufer and switch to the previous one", silent = true })

-- quickfix management
vim.keymap.set("n", "<leader>qc", ":cclose<CR>")
vim.keymap.set("n", "<leader>qh", ":cprev<CR>")
vim.keymap.set("n", "<leader>ql", ":cnext<CR>")
vim.keymap.set("n", "<leader>qo", ":copen<CR>")

-- test the current '*_spec.lua' file
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*_spec.lua" },
    callback = function()
        vim.keymap.set("n", "<leader>tf", ":PlenaryBustedFile %<cr>")
    end,
})
