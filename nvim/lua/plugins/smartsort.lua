return {
    "smartsort.nvim",
    dev = true,
    config = function ()
        vim.keymap.set("c", ":ss", require('smartsort').sort)
    end
}
