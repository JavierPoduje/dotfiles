return {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
        -- { "nvim-lua/popup.nvim" },
        -- { "sharkdp/fd" },
        { "catgoose/telescope-helpgrep.nvim" },
        { "nvim-telescope/telescope-fzy-native.nvim" },
        { "nvim-telescope/telescope-live-grep-args.nvim" },
    },
    config = function()
        local actions = require("telescope.actions")
        local sorters = require("telescope.sorters")
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<ESC>"] = actions.close,
                        ["<C-q>"] = actions.delete_buffer,
                        ["<Tab>"] = actions.send_to_qflist,
                    },
                },
                ripgrep_arguments = {
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
                        width = 0.9,
                        mirror = false,
                        preview_width = 0.5,
                        prompt_position = "top",
                    },
                    vertical = {
                        width = 0.9,
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
            },
            extensions = {
                fzy_native = {
                    override_generic_sorter = false,
                    override_file_sorter = true,
                }
            }
        })

        telescope.load_extension("fzy_native")
        telescope.load_extension("helpgrep")
    end,
    keys = {
        {
            mode = "n",
            "<leader>pf",
            require('telescope.builtin').find_files,
            desc = "Find files in the current directory",
            silent = true,
        },
        {
            mode = "n",
            "<leader>pb",
            require('telescope.builtin').buffers,
            desc = "List open buffers",
            silent = true,
        },
        {
            mode = "n",
            "<leader>ps",
            ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>\"\"<left>",
            desc = "Search by text with args if needed",
            silent = true,
        },
        {
            mode = "n",
            "<leader>pr",
            require("telescope.builtin").resume,
            desc = "Resume the last telescope session",
            silent = true,
        },
        {
            mode = "n",
            "<leader>pa",
            ":Telescope grep_string<CR>",
            desc = "Search for the `word` under the cursor",
            silent = true,
        },
        {
            mode = "n",
            "<leader>pgs",
            ":Telescope live_grep search_dirs=",
            desc = "Search for a string in a directory scope",
        },
        {
            mode = "n",
            "<leader>pd",
            ":lua require('telescope.builtin').diagnostics({ bufnr = 0 })<CR>",
            desc = "List diagnostics for the current buffer",
            silent = true,
        },
        {
            mode = "n",
            "<leader>pw",
            ":lua require('telescope.builtin').diagnostics()<CR>",
            desc = "List diagnostics for the entire workspace",
            silent = true,
        },
        {
            mode = "n",
            "<leader>p<Tab>",
            function()
                local quickfixList = vim.fn.getqflist()
                if #quickfixList > 0 then
                    vim.cmd("Telescope quickfix")
                else
                    print("Empty quickfix list...")
                end
            end,
            desc = "Browse quickfix list",
            silent = true,
        },
        {
            mode = "n",
            "<leader>pn",
            function()
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
            end,
            desc = "search nvim-config files",
            silent = true,
        },
        {
            mode = "v",
            "<leader>py",
            function()
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
            end,
            desc = "Search visually selected text",
            silent = true,
        },
        {
            mode = "n",
            "<leader>ph",
            ":Telescope helpgrep<CR>",
            desc = "Search string in help files",
            silent = true,
        },
    },
}
