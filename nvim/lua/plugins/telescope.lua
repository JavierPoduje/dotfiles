local browse_nvim = function()
	require("telescope.builtin").find_files({
		results_title = "~ Vim ~",
		cwd = "~/.config/nvim/",
		previewer = false,
		prompt_title = false,
		layout_strategy = "vertical",
		layout_config = {
			width = 0.4,
			height = 0.4,
		},
	})
end

local search_visual_selection = function()
	local _, start_line, start_col, _ = unpack(vim.fn.getpos("'<"))
	local _, end_line, end_col, _ = unpack(vim.fn.getpos("'>"))
	local lines = vim.fn.getline(start_line, end_line)

	if start_line ~= end_line then
		lines[#lines] = string.sub(lines[#lines], 1, end_col)
		lines[1] = string.sub(lines[1], start_col)
	else
		lines[1] = string.sub(lines[1], start_col, end_col)
	end

	local selection = table.concat(lines, "\n")

	require("telescope.builtin").grep_string({
		search = selection,
	})
end

local browse_quickfix_list = function()
	local quickfixList = vim.fn.getqflist()
	if #quickfixList > 0 then
		vim.cmd("Telescope quickfix")
	else
		print("Empty quickfix list...")
	end
end

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "catgoose/telescope-helpgrep.nvim" },
		{ "nvim-lua/popup.nvim" },
		{ "nvim-telescope/telescope-fzy-native.nvim" },
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
		{ "romgrk/fzy-lua-native" },
		{ "sharkdp/fd" },
	},
	config = function()
		local action_state = require("telescope.actions.state")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local previewers = require("telescope.previewers")
		local sorters = require("telescope.sorters")
		local telescope = require("telescope")

		local silent = { noremap = true, silent = true }

		local fzf_multi_select = function(prompt_bufnr)
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
						["<CR>"] = fzf_multi_select,
					},
				},
				vimgrep_arguments = {
					"rg",
					"--hidden",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				prompt_prefix = "  ",
				selection_caret = " ",
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
					"go.sum",
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
				helpgrep = {
					ignore_paths = {
						vim.fn.stdpath("state") .. "/lazy/readme",
					},
					mappings = {
						i = {
							["<CR>"] = actions.select_default,
							["<C-v>"] = actions.select_vertical,
						},
						n = {
							["<CR>"] = actions.select_default,
							["<C-s>"] = actions.select_horizontal,
						},
					},
					default_grep = builtin.live_grep,
				},
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
		telescope.load_extension("helpgrep")

		-- Native
		vim.keymap.set("n", "<Leader>pf", ":Telescope find_files<CR>", silent)
		vim.keymap.set("n", "<Leader>pb", ":Telescope buffers<CR>", silent)
		vim.keymap.set(
			"n",
			"<Leader>ps",
			":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>\"\"<left>",
			silent
		)
		vim.keymap.set("n", "<Leader>pr", builtin.resume, silent)
		vim.keymap.set("n", "<Leader>pa", ":Telescope grep_string<CR>", silent)
		vim.keymap.set("n", "<Leader>pgs", ":Telescope live_grep search_dirs=")
		vim.keymap.set("n", "<Leader>pd", ":lua require('telescope.builtin').diagnostics({ bufnr = 0 })<CR>", silent)

		-- Customs
		vim.keymap.set("n", "<Leader>p<Tab>", browse_quickfix_list, silent)
		vim.keymap.set("n", "<Leader>pn", browse_nvim, silent)
		vim.keymap.set("v", "<Leader>py", search_visual_selection, silent)
		vim.keymap.set("n", "<Leader>pt", ":tabs<CR>", silent)
		vim.keymap.set("n", "<Leader>ph", ":Telescope helpgrep<CR>", silent)
	end,
}
