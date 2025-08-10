return {
    "NStefan002/screenkey.nvim",
    lazy = false,
    enabled = false,
    config = function()
        require("screenkey").setup({
            win_opts = {
                title = '',
                row = (vim.o.lines / 2) + 2 - vim.o.cmdheight - 1,
                col = vim.o.columns,
            },
        })

        vim.cmd("Screenkey")
    end,
}
