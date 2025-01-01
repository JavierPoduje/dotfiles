vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.api.nvim_command("syntax on")
vim.api.nvim_command("filetype plugin on")

vim.api.nvim_command("set nocompatible")
vim.api.nvim_command("set exrc")

vim.o.exrc = true
vim.opt.clipboard = "unnamedplus"
vim.opt.colorcolumn = "100"
vim.opt.expandtab = true   -- expand tab input with spaces characters
vim.opt.fdm = "indent"     -- folding method
vim.opt.foldenable = false -- disable pre-folding
vim.opt.foldlevel = 10     -- fix initial folding
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.mouse = "a"
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 6
vim.opt.shiftwidth = 2 -- spaces per indentation level
vim.opt.showmatch = false
vim.opt.showtabline = 2
vim.opt.signcolumn = "yes:1"
vim.opt.smartcase = true
vim.opt.smartindent = true -- syntax aware indentations for newline inserts
vim.opt.tabstop = 2        -- num of space characters per tab
vim.opt.termguicolors = true
vim.opt.updatetime = 50
vim.opt.wrap = false


vim.api.nvim_command("set encoding=utf8")
vim.api.nvim_command("set hidden")
vim.api.nvim_command("set ignorecase")
vim.api.nvim_command("set laststatus=3")
vim.api.nvim_command("set noerrorbells")
vim.api.nvim_command("set shiftwidth=2")
vim.api.nvim_command([[ set listchars=eol:⏎,tab:→\ ,trail:␠,nbsp:⎵,space:·,extends:⟩,precedes:⟨ ]])
vim.api.nvim_command([[ set showbreak=↪\ ]])

-- cursorline only in focused buffer
vim.api.nvim_command([[
set cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
]])

-- Spelling for English and Spanish. Not active at start
vim.api.nvim_command("set spelllang=en_us,es")

-- Handle backup files
vim.opt.swapfile = false
vim.opt.backup = false
vim.api.nvim_command("set undodir=~/.config/nvim/undodir")
vim.opt.undofile = true

-- More space for displaying messages.
vim.api.nvim_command("set cmdheight=1")

-- Don't pass messages to |ins-completion-menu|.
vim.api.nvim_command("set shortmess+=c")

-- stable background
vim.api.nvim_command("let &t_ut=''")

-- I don't know what this things are...
vim.api.nvim_command("set t_Co=256")
vim.g.loaded_matchparen = 1
vim.g.vrfr_rg = "true"
vim.g.netrw_bufsettings = "noma nomod nu nowrap ro nobl"

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
vim.api.nvim_command("autocmd FileType help wincmd L")

-- and tsconfig.json is actually jsonc, help TypeScript set the correct filetype
vim.api.nvim_command([[
	autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc
]])

vim.api.nvim_create_autocmd(
    "BufEnter",
    { pattern = "*.templ", command = "setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4" }
)
vim.api.nvim_create_autocmd(
    "BufEnter",
    { pattern = "Makefile", command = "setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4" }
)

vim.g.markdown_fenced_languages = { "html", "lua", "vim", "typescript", "javascript" }

-- GLOBAL FUNCTIONS

-- Inspected version of `print`
P = function(x)
    print(vim.inspect(x))
    return x
end
