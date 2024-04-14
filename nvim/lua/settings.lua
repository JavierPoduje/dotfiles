v.nvim_command("syntax on")
v.nvim_command("filetype plugin on")

v.nvim_command("set nocompatible")
v.nvim_command("set exrc")

vim.o.exrc = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.smartindent = true
vim.opt.showmatch = false
vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 6
vim.opt.wrap = false
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.smartcase = true
vim.opt.fdm = "indent" -- folding method
vim.opt.foldenable = false -- disable pre-folding
vim.opt.foldlevel = 10 -- fix initial folding

v.nvim_command("set hidden")
v.nvim_command("set noerrorbells")
v.nvim_command("set tabstop=2 softtabstop=0 expandtab smarttab")
v.nvim_command("set laststatus=3")
v.nvim_command("set shiftwidth=2")
v.nvim_command("set ignorecase")
v.nvim_command("set encoding=utf8")
v.nvim_command("set list")
v.nvim_command([[ set showbreak=↪\ ]])
v.nvim_command([[ set listchars=eol:⏎,tab:→\ ,trail:␠,nbsp:⎵,space:·,extends:⟩,precedes:⟨ ]])

-- cursorline only in focused buffer
v.nvim_command([[
set cursorline
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
]])

-- Spelling for English and Spanish. Not active at start
v.nvim_command("set spelllang=en_us,es")

-- Handle backup files
vim.opt.swapfile = false
vim.opt.backup = false
v.nvim_command("set undodir=~/.config/nvim/undodir")
vim.opt.undofile = true

-- More space for displaying messages.
v.nvim_command("set cmdheight=1")

-- Don't pass messages to |ins-completion-menu|.
v.nvim_command("set shortmess+=c")

-- <Space> as leader key
vim.g.mapleader = " "

-- Having longer update time (default is 4000 ms = 4 sec) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50
--v.nvim_command("set updatetime=300")

-- Always show tabs on top
v.nvim_command("set showtabline=2")

-- stable background
v.nvim_command("let &t_ut=''")

-- I don't know what this things are...
v.nvim_command("set t_Co=256")
vim.g.loaded_matchparen = 1
--vim.g.netrw_browse_split = 2
vim.g.vrfr_rg = "true"
vim.g.netrw_bufsettings = "noma nomod nu nowrap ro nobl"
--vim.g.netrw_banner = 1
--vim.g.netrw_winsize = 15

-- Remove white spaces on save
v.nvim_command([[
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun
autocmd BufWritePre * :call TrimWhitespace()
]])

-- open :help menu in a vertical split
v.nvim_command("autocmd FileType help wincmd L")

-- Set indentation for .php, .sql, and .mysql files
-- and tsconfig.json is actually jsonc, help TypeScript set the correct filetype
v.nvim_command([[
	autocmd FileType php setlocal shiftwidth=4 softtabstop=4 expandtab
	autocmd FileType sql setlocal shiftwidth=4 softtabstop=4 expandtab
	autocmd FileType mysql setlocal shiftwidth=4 softtabstop=4 expandtab
	autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc
]])

vim.api.nvim_create_autocmd("BufEnter", { pattern = "*.lua", command = "setlocal noexpandtab" })

vim.g.markdown_fenced_languages = { "html", "python", "lua", "vim", "typescript", "javascript" }
