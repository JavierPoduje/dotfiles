return {
    "nvim-lua/plenary.nvim",
    lazy = false,
    config = function()
        -- test the current '*_spec.lua' file
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = { "*_spec.lua" },
            callback = function()
                local openTerminalAndRunLuaTests = function()
                    -- Get current file path
                    local file_to_test = vim.fn.expand('%')

                    vim.cmd("enew")
                    vim.cmd("terminal")

                    -- Construct and run the command
                    local cmd = string.format(
                        "nvim --headless --noplugin -u scripts/minimal_init.vim -c \"PlenaryBustedDirectory %s { minimal_init = './scripts/minimal_init.vim' }\"",
                        file_to_test
                    )

                    -- Set up autocmd to close terminal buffer when pressing 'q'
                    vim.api.nvim_create_autocmd("TermEnter", {
                        buffer = vim.api.nvim_get_current_buf(),
                        callback = function()
                            vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:bd!<CR>", { buffer = true })
                        end,
                    })

                    -- Send the command to terminal
                    vim.fn.chansend(vim.b.terminal_job_id, cmd .. "\n")
                    vim.cmd("startinsert")
                end

                vim.keymap.set("n", "<leader>tf", openTerminalAndRunLuaTests)
            end,
        })
    end
}
