return {
    "smartsort.nvim",
    dev = true,
    config = function()
        require('smartsort').setup({
            hola = 'hello',
        })
        vim.keymap.set("v", "<leader>0", ":Smartsort")
    end
}
