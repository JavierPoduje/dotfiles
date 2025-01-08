return {
    "tpope/vim-fugitive",
    keys = {
        { "<leader>gl", ":diffget //3<CR>", silent = true },
        { "<leader>gh", ":diffget //2<CR>", silent = true },
        { "<leader>gs", ":G<CR>", silent = true },
        { "<leader>gb", ":Git blame<CR>", silent = true },
        { "<leader>gp", ":GitGutterPreviewHunk<CR>", silent = true },
    },
    config = function() end,
}
