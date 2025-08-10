return {
    "smartsort.nvim",
    dev = true,
    lazy = false,
    config = function()
        local setup = '{non_sortable_behavior = "preserve"}'

        require('smartsort').setup({
            non_sortable_behavior = "preserve",
            single_line_separator = ",",
        })

        vim.keymap.set("v", "<leader>0", ":Smartsort")
        vim.keymap.set("n", "<leader>9", ":SReload<cr>")
        vim.keymap.set("v", "<leader>8", ":SPrintChadnode<cr>")
        vim.keymap.set("v", "<leader>7", ":'<,'>lua require('smartsort').smartsort(" .. setup .. ")")
    end
}
