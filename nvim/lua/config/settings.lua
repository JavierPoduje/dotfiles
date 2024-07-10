vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.api.nvim_command("syntax on")
vim.api.nvim_command("filetype plugin on")

vim.api.nvim_command("set nocompatible")
vim.api.nvim_command("set exrc")

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

vim.api.nvim_command("set hidden")
vim.api.nvim_command("set noerrorbells")
vim.api.nvim_command("set tabstop=2 softtabstop=0 expandtab smarttab")
vim.api.nvim_command("set laststatus=3")
vim.api.nvim_command("set shiftwidth=2")
vim.api.nvim_command("set ignorecase")
vim.api.nvim_command("set encoding=utf8")
vim.opt.list = true
vim.api.nvim_command([[ set showbreak=↪\ ]])
vim.api.nvim_command([[ set listchars=eol:⏎,tab:→\ ,trail:␠,nbsp:⎵,space:·,extends:⟩,precedes:⟨ ]])

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

-- Having longer update time (default is 4000 ms = 4 sec) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50
--vim.api.nvim_command("set updatetime=300")

-- Always show tabs on top
vim.api.nvim_command("set showtabline=2")

-- stable background
vim.api.nvim_command("let &t_ut=''")

-- I don't know what this things are...
vim.api.nvim_command("set t_Co=256")
vim.g.loaded_matchparen = 1
vim.g.vrfr_rg = "true"
vim.g.netrw_bufsettings = "noma nomod nu nowrap ro nobl"

-- Remove white spaces on save
vim.api.nvim_command([[
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun
autocmd BufWritePre * :call TrimWhitespace()
]])

-- open :help menu in a vertical split
vim.api.nvim_command("autocmd FileType help wincmd L")

-- Set indentation for .php, .sql, and .mysql files
-- and tsconfig.json is actually jsonc, help TypeScript set the correct filetype
vim.api.nvim_command([[
	autocmd FileType php setlocal shiftwidth=4 softtabstop=4 expandtab
	autocmd FileType sql setlocal shiftwidth=4 softtabstop=4 expandtab
	autocmd FileType mysql setlocal shiftwidth=4 softtabstop=4 expandtab
	autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc
]])

vim.api.nvim_create_autocmd(
	"BufEnter",
	{ pattern = "*.lua", command = "setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4" }
)
vim.api.nvim_create_autocmd(
	"BufEnter",
	{ pattern = "*.go", command = "setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4" }
)
vim.api.nvim_create_autocmd(
	"BufEnter",
	{ pattern = "*.templ", command = "setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4" }
)
vim.api.nvim_create_autocmd(
	"BufEnter",
	{ pattern = "Makefile", command = "setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4" }
)

vim.g.markdown_fenced_languages = { "html", "python", "lua", "vim", "typescript", "javascript" }

-- GLOBAL FUNCTIONS

-- Inspected version of `print`
P = function(x)
	print(vim.inspect(x))
	return x
end

-- Convert json to php array
JsonToPhp = function()
	vim.api.nvim_command([[ :%s/\%V":\s*\"/" => "/ge ]])
	vim.api.nvim_command([[ :%s/\%V":\s*{/" => [/ge ]])
	vim.api.nvim_command([[ :%s/\%V":\s*\[/" => [/ge ]])
	vim.api.nvim_command([[ :%s/\%V{/[/ge ]])
	vim.api.nvim_command([[ :%s/\%V}/]/ge ]])
	vim.api.nvim_command([[ :%s/\%V":\s*/" => /ge ]])
end

--vim.cmd.colorscheme("lunaperche")
