return {
    "smartsort.nvim",
    dev = true,
    config = function()
        local setup = '{non_sortable_behavior = "preserve",separator = ","}'

        require('smartsort').setup({
            non_sortable_behavior = "preserve",
            separator = ",",
        })

        vim.keymap.set("v", "<leader>0", ":Smartsort")
        vim.keymap.set("n", "<leader>9", ":SReload<cr>")
        vim.keymap.set("v", "<leader>8", ":SPrintChadnode<cr>")
        vim.keymap.set("v", "<leader>7",
            ":'<,'>lua require('smartsort').smartsort(" .. setup .. ")")
    end
}
