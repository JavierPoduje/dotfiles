return {
    "javierpoduje/taboo",
    keys = {
        { "<Leader>tt", ":TabooOpen<CR>", desc = "Display taboo", silent = true },
    },
    config = function()
        require("taboo")
    end,
    --dev = true,
}
