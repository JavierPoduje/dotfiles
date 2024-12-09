return {
    "kdheepak/lazygit.nvim",
    keys = {
        { "<Leader>gg", ":LazyGit<CR>", silent = true },
    },
    config = function()
        vim.g.lazygit_floating_window_scaling_factor = 1
    end,
}
