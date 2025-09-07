return {
    "smartsort.nvim",
    dev = true,
    config = function()
        local setup = '{non_sortable_behavior = "preserve"}'

        require('smartsort').setup({
            non_sortable_behavior = "preserve",
            single_line_separator = ",",
            -- treesitter = {
            --     javascript = {
            --         expression_statement = [[
            --             (expression_statement
            --               (call_expression
            --                 function: (member_expression
            --                   object: (identifier) @object (#eq? @object "console")
            --                   property: (property_identifier) @property (#eq? @property "log")
            --                 )
            --                 (arguments
            --                   (string (string_fragment) @identifier)
            --                 )
            --               )
            --             ) @block
            --         ]]
            --     },
            -- }
        })

        vim.keymap.set("v", "<leader>0", ":Smartsort")
        vim.keymap.set("n", "<leader>9", ":SReload<cr>")
        vim.keymap.set("v", "<leader>8", ":SPrintChadnode<cr>")
        vim.keymap.set("v", "<leader>7", ":'<,'>lua require('smartsort').smartsort(" .. setup .. ")")
    end
}
