local telescope = require("telescope")
local sorters = require("telescope.sorters")
local previewers = require("telescope.previewers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local custom_actions = {}

function custom_actions.fzf_multi_select(prompt_bufnr)
	local picker = action_state.get_current_picker(prompt_bufnr)
	local num_selections = #picker:get_multi_selection()

	if num_selections > 1 then
		actions.send_selected_to_qflist(prompt_bufnr)
		actions.open_qflist()
	else
		actions.file_edit(prompt_bufnr)
	end
end

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<ESC>"] = actions.close,
				["<C-q>"] = actions.delete_buffer,
				["<Tab>"] = actions.send_to_qflist,
				["<CR>"] = custom_actions.fzf_multi_select,
			},
		},
		vimgrep_arguments = {
			"rg",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = "  ",
		selection_caret = " ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				width = 0.8,
				mirror = false,
				preview_width = 0.5,
				prompt_position = "top",
			},
			vertical = {
				width = 0.6,
				mirror = true,
				preview_height = 0.5,
				prompt_position = "top",
			},
		},
		file_sorter = sorters.get_fuzzy_file,
		file_ignore_patterns = {
			"*.pyc",
			"app/webroot/bower_components",
			"app/webroot/build",
			"app/webroot/img",
			"app/webroot/legacy-tables",
			"app/webroot/tmp",
			"aws/",
			"aws/dist",
		},
		generic_sorter = sorters.get_generic_fuzzy_sorter,
		color_devicons = true,
		use_less = true,
		path_display = {},
		set_env = { ["COLORTERM"] = "truecolor" },
		file_previewer = previewers.vim_buffer_cat.new,
		grep_previewer = previewers.vim_buffer_vimgrep.new,
		qflist_previewer = previewers.vim_buffer_qflist.new,
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
		tele_tabby = {
			use_highlighter = true,
		},
	},
})

telescope.load_extension("fzy_native")
telescope.load_extension("fzy_native")

-- Native
vim.keymap.set("n", "<Leader>pf", ":Telescope find_files<CR>")
vim.keymap.set("n", "<Leader>pb", ":Telescope buffers<CR>")
vim.keymap.set("n", "<Leader>ps", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>\"\"<left>")
vim.keymap.set("n", "<Leader>pa", ":Telescope grep_string<CR>")
vim.keymap.set("n", "<Leader>pgs", ":Telescope live_grep search_dirs=", { noremap = true, silent = false })

-- Customs
local F = "require'config.telescope.finders'"
vim.keymap.set("n", "<Leader>p<Tab>", ":lua " .. F .. ".browse_quickfix_list()<CR>")
vim.keymap.set("n", "<Leader>pu", ":lua " .. F .. ".browse_utils()<CR>")
vim.keymap.set("n", "<Leader>pn", ":lua " .. F .. ".browse_nvim()<CR>")
vim.keymap.set("n", "<Leader>ph", ":lua " .. F .. ".browse_marks()<CR>")
vim.keymap.set("v", "<Leader>py", ":lua " .. F .. ".get_visual_selection()<CR>")
vim.keymap.set("n", "<Leader>pt", ":tabs<CR>")
