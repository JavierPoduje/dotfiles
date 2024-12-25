return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup({
            settings = {
                save_on_toggle = true,
            },
        })

        for char, num in pairs(require("utils").left_num_by_char) do
            vim.keymap.set("n", "<Leader>y" .. char, function() harpoon:list():select(num) end)
        end

        vim.keymap.set("n", "<leader>ya", function() harpoon:list():add() end)
        vim.keymap.set(
            "n",
            "<leader>yt",
            function() harpoon.ui:toggle_quick_menu(harpoon:list()) end
        )
        vim.keymap.set("n", "<C-PageUp>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<C-PageDown>", function() harpoon:list():next() end)
    end,
}
