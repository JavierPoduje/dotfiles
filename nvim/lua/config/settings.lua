vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.markdown_fenced_languages = { "html", "javascript", "lua", "typescript", "vim" }
vim.o.exrc = true
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "100"
-- vim.opt.cursorline = true
vim.opt.encoding = "utf8"
vim.opt.errorbells = false
vim.opt.expandtab = true   -- expand tab input with spaces characters
vim.opt.fdm = "indent"     -- folding method
vim.opt.foldenable = false -- disable pre-folding
vim.opt.foldlevel = 10     -- fix initial folding
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { eol = "⏎", extends = "⟩", nbsp = "⎵", precedes = "⟨", space = "·", tab = "→ ", trail = "␠", }
vim.opt.mouse = "a"
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 6
vim.opt.shiftwidth = 2
vim.opt.shiftwidth = 2 -- spaces per indentation level
vim.opt.showmatch = false
vim.opt.showtabline = 2
vim.opt.signcolumn = "yes:1"
vim.opt.smartcase = true
vim.opt.smartindent = true -- syntax aware indentations for newline inserts
vim.opt.spelllang = { "en_us", "es" }
vim.opt.swapfile = false
vim.opt.tabstop = 2 -- num of space characters per tab
vim.opt.termguicolors = true
vim.opt.undodir = vim.fn.expand("~/.config/nvim/undodir")
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.wrap = false

-- options:
-- ayu
-- catppuccin
-- gruvbox-material
-- kanagawa
vim.g.colorscheme = "gruvbox-material"

-- cursorline only in focused buffer
-- vim.api.nvim_create_autocmd({ "WinEnter" }, { callback = function() vim.opt_local.cursorline = true end })
-- vim.api.nvim_create_autocmd({ "WinLeave" }, { callback = function() vim.opt_local.cursorline = false end })

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append("c")

-- Remove white spaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        local save = vim.fn.winsaveview()
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.fn.winrestview(save)
    end,
})

-- open :help menu in a vertical split
vim.api.nvim_create_autocmd("FileType", { pattern = "help", command = "wincmd L" })

-- and tsconfig.json is actually jsonc, help TypeScript set the correct filetype
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--     pattern = "tsconfig.json",
--     callback = function() vim.bo.filetype = "jsonc" end,
-- })

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.templ", "Makefile" },
    callback = function()
        vim.bo.expandtab = false
        vim.bo.shiftwidth = 4
        vim.bo.softtabstop = 4
        vim.bo.tabstop = 4
    end,
})

-- Inspected version of `print`
P = function(x)
    print(vim.inspect(x))
    return x
end
