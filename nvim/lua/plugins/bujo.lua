return {
    "vuciv/vim-bujo",
    config = function()
        -- Set todo lists cache file
        vim.api.nvim_command([[
            let g:bujo#todo_file_path = $HOME . "/.config/nvim/cache/bujo"
            let g:bujo#window_width = 100
        ]])
    end,
}
