return {
    "airblade/vim-gitgutter",
    config = function()
        -- Deactive GitGutter commands to avoid slow <leader>+h execution
        vim.g.gitgutter_map_keys = 0
    end,
}
